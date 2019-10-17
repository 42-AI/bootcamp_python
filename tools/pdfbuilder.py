from reportlab.lib.enums import TA_JUSTIFY, TA_CENTER, TA_LEFT
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Image, PageBreak, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch, cm

from glob import glob

def loaddata(filename):
    with open(filename) as f:
        lines = f.readlines()
        data = []
        isCode = False
        isTable = False
        buffer_code = ""
        buffer_table = []
        for line in lines:
            line = line.strip('\n')
            if line == "":
                data.append(('space', ''))
                continue
            title = line.split(' ')[0]
            
            # Code
            if len(title) >= 3 and title[:3] == '```':
                if isCode == True:
                    data.append(('code', buffer_code))
                    buffer_code = ""
                    isCode = False
                else:
                    isCode = True
                continue
            if isCode == True:
                line = line.replace('\t', '&nbsp;&nbsp;&nbsp;&nbsp;').replace('    ', '&nbsp;&nbsp;&nbsp;&nbsp;')
                buffer_code += line + "<br/>"
                continue
            
            # Table
            if len(line) > 0 and line[0] == '|':
                isTable = True
                tmp = line.strip('|').split('|')
                tmp = [val.strip() for val in tmp]
                if all(char in ':- ' for char in ''.join(tmp)):
                    continue
                buffer_table.append(tmp)
                continue
            else:
                if isTable == True:
                    data.append(('table', buffer_table))
                    buffer_table = []
                    isTable = False
                    continue
            
            # Headers
            if title == "#":
                data.append(('h1', line.strip('# ')))
                continue
            elif title == "##":
                data.append(('h2', line.strip('# ')))
                continue
            elif title == "###":
                data.append(('h3', line.strip('# ')))
                continue
            
            # List
            if len(title) == 1 and title[0] == '*':
                data.append(('list', line.strip(' *')))
                continue

            # Others
            data.append(('other', line.strip('# ')))
    return data

class PDFBuilder():

    def __init__(self, dir):
        self.name = dir 
        self.doc = SimpleDocTemplate(
            self.name + ".pdf",
            pagesize=letter,
            rightMargin=72, 
            leftMargin=72,
            topMargin=72, 
            bottomMargin=18,
        )
        styles=getSampleStyleSheet()
        styles.add(ParagraphStyle(name='ai_other', parent=styles['Normal'], alignment=TA_JUSTIFY, fontSize=11))
        styles.add(ParagraphStyle(name='main_title', parent=styles['Normal'], leading=30, alignment=TA_CENTER, fontSize=40, fontName="Helvetica-Bold"))
        styles.add(ParagraphStyle(name='ai_h1', parent=styles['Normal'], leading=30, alignment=TA_CENTER, fontSize=30, fontName="Helvetica-Bold"))
        styles.add(ParagraphStyle(name='ai_h2', parent=styles['Normal'], leading=20, alignment=TA_LEFT, fontSize=20, fontName="Helvetica-Bold"))
        styles.add(ParagraphStyle(name='ai_h3', parent=styles['Normal'], leading=20, alignment=TA_LEFT, fontSize=14, fontName="Helvetica-Bold"))
        styles.add(ParagraphStyle(name='ai_code', parent=styles['Normal'], fontName="Courier-Bold", backColor='black', textColor='white', borderPadding=0.2*cm))
        self.styles = styles

    @staticmethod
    def BackGroundSetup(canvas, _):
        background = 'background_42_ai.png'
        canvas.saveState()
        width, height = letter
        canvas.drawImage(background, 0, 0, width, height)
        canvas.restoreState()

    def FirstPage(self, Story):
        Story.append(Spacer(1, 2*cm))
        Story.append(Paragraph('Bootcamp', self.styles['main_title']))
        Story.append(Spacer(1, 12))
        Story.append(Paragraph('Python', self.styles['main_title']))
        Story.append(Spacer(1, 4*cm))
        im = Image('logo_v4_noir.png', 6*cm, 6*cm)
        Story.append(im)    
        Story.append(PageBreak())
        return Story

    def MainPage(self, Story, filename):
        data = loaddata(filename)
        Story = self.FirstPage(Story)
        for tType, Content in data[1:]:
            if tType == 'space':
                Story.append(Spacer(1, 12))
                continue
            if tType == 'table':
                table = Table(self.TableFormater(Content), colWidths=[5*cm, 10*cm], hAlign='LEFT')
                table.setStyle(TableStyle([
                    ('INNERGRID', (0,0), (-1,-1), 0.25, colors.black),
                    ('BOX', (0,0), (-1,-1), 0.25, colors.black),
                ]))
                Story.append(table)
                continue
            if self.styles.has_key('ai_' + tType):
                Story.append(Paragraph(Content, self.styles['ai_' + tType]))
                if tType == 'h1':
                   Story.append(Spacer(1, 1*cm))
                continue
            if tType == 'list':
                Story.append(Paragraph('- ' + Content, self.styles["Bullet"]))
                continue
            Story.append(Paragraph(Content, self.styles["ai_other"]))
        Story.append(PageBreak())
        return Story

    def TableFormater(self, content):
        table = []
        for line in content:
            table.append([Paragraph(elem, self.styles['ai_other']) for elem in line])
        return table

    def BuildExercice(self, Story, filename):
        data = loaddata(filename)
        for tType, Content in data:
            if tType == 'space':
                Story.append(Spacer(1, 12))
                continue
            if tType == 'table':
                table = Table(self.TableFormater(Content), colWidths=[5*cm, 10*cm], hAlign='LEFT')
                table.setStyle(TableStyle([
                    ('INNERGRID', (0,0), (-1,-1), 0.25, colors.black),
                    ('BOX', (0,0), (-1,-1), 0.25, colors.black),
                ]))
                Story.append(table)
                continue
            if self.styles.has_key('ai_' + tType):
                Story.append(Paragraph(Content, self.styles['ai_' + tType]))
                if tType == 'h1':
                   Story.append(Spacer(1, 1*cm))
                continue
            if tType == 'list':
                Story.append(Paragraph('- ' + Content, self.styles["Bullet"]))
                continue
            Story.append(Paragraph(Content, self.styles["ai_other"]))
        Story.append(PageBreak())
        return Story

    def SavePDF(self, Story):
        self.doc.build(
            Story,
            onFirstPage=PDFBuilder.BackGroundSetup,
            onLaterPages=PDFBuilder.BackGroundSetup,
        )
    

    def Build(self):
        Story=[]
        dir = name=self.name
        main_file = "{dir}/{name}.md".format(dir=dir, name=self.name)
        exercices = glob(dir + '/ex*/*.md')
        Story = self.MainPage(Story, main_file)
        for file in exercices:
            Story = self.BuildExercice(Story, file)
        self.SavePDF(Story)

if __name__ == "__main__":
    for day in glob("day*"):
        if '.' in day:
            continue
        pdf = PDFBuilder(day)
        pdf.Build()
    

    