from glob import glob

from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate
from reportlab.platypus import Paragraph
from reportlab.platypus import Spacer
from reportlab.platypus import Image
from reportlab.platypus import PageBreak
from reportlab.platypus import Table
from reportlab.platypus import TableStyle
from reportlab.lib.units import cm

from md_loader import LoadMDfile
from styles_config import styles

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
        self.styles = styles

    @staticmethod
    def BackGroundSetup(canvas, _):
        background = 'tools/background_42_ai.png'
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
        im = Image('tools/logo_v4_noir.png', 6*cm, 6*cm)
        Story.append(im)    
        Story.append(PageBreak())
        return Story

    def MainPage(self, Story, filename):
        data = LoadMDfile().readfile(filename)
        Story = self.FirstPage(Story)
        for tType, Content in data[1:]:
            if tType == 'space':
                Story.append(Spacer(1, 15))
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
                Story.append(Spacer(1, 5))
                continue
            if tType == 'list':
                Story.append(Paragraph('- ' + Content, self.styles["Bullet"]))
                Story.append(Spacer(1, 5))
                continue
            Story.append(Paragraph(Content, self.styles["ai_other"]))
            Story.append(Spacer(1, 5))
        Story.append(PageBreak())
        return Story

    def TableFormater(self, content):
        table = []
        for line in content:
            table.append([Paragraph(elem, self.styles['ai_other']) for elem in line])
        return table

    def BuildExercice(self, Story, filename):
        data = LoadMDfile().readfile(filename)
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
                Story.append(Spacer(1, 1*cm))
                continue
            if self.styles.has_key('ai_' + tType):
                if tType == 'code':
                    Story.append(Spacer(1, 5))
                Story.append(Paragraph(Content, self.styles['ai_' + tType]))
                if tType == 'code':
                    Story.append(Spacer(1, 5))
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
        exercices.sort()
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
    

    