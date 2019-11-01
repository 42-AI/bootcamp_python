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

from mdloader import LoadMDfile
from stylesconfig import styles


class PDFBuilder:
    def __init__(self, directory):
        self.name = directory
        self.doc = SimpleDocTemplate(
            self.name + ".pdf",
            pagesize=letter,
            rightMargin=72,
            leftMargin=72,
            topMargin=72,
            bottomMargin=42,
        )
        self.styles = styles

    @staticmethod
    def BackGroundSetup(canvas, _):
        background = "tools/background_42_ai.png"
        canvas.saveState()
        width, height = letter
        canvas.drawImage(background, 0, 0, width, height)
        canvas.restoreState()

    def FirstPage(self, Story):
        Story.append(Spacer(1, 2 * cm))
        Story.append(Paragraph("Bootcamp", self.styles["main_title"]))
        Story.append(Spacer(1, 12))
        Story.append(Paragraph("Python", self.styles["main_title"]))
        Story.append(Spacer(1, 4 * cm))
        im = Image("tools/logo_v4_noir.png", 6 * cm, 6 * cm)
        Story.append(im)
        Story.append(PageBreak())
        return Story

    def MainPage(self, Story, filename):
        data = LoadMDfile().readfile(filename)
        Story = self.FirstPage(Story)
        for tType, Content in data[1:]:
            if tType == "space":
                Story.append(Spacer(1, 12))
                continue
            if tType == "table":
                Story = self.addTable(Story, Content)
                continue
            if tType == "code":
                Story = self.addCode(Story, Content)
                continue
            if tType == "h1":
                Story = self.addH1(Story, Content)
                continue
            if tType == "h2":
                Story = self.addH2(Story, Content)
                continue
            if tType == "h3":
                Story = self.addH3(Story, Content)
                continue
            if tType == "list":
                Story = self.addList(Story, Content)
                continue
            Story = self.addOther(Story, Content)
        Story.append(PageBreak())
        return Story

    def TableFormater(self, content):
        table = []
        for line in content:
            table.append([Paragraph(elem, self.styles["ai_other"]) for elem in line])
        return table

    def addH1(self, Story, Content):
        Story.append(Paragraph(Content, self.styles["ai_h1"]))
        Story.append(Spacer(1, 1 * cm))
        return Story

    def addH2(self, Story, Content):
        Story.append(Paragraph(Content, self.styles["ai_h2"]))
        return Story

    def addH3(self, Story, Content):
        Story.append(Paragraph(Content, self.styles["ai_h3"]))
        return Story

    def addImage(self, Story, Content):
        table = Table(
            data=[[Image(Content, 12*cm, 8*cm)]],
            colWidths=12*cm,
            rowHeights=8*cm,
            style=[
                ('ALIGN', (0, 0), (0, 0), 'CENTER'),
                ('BOX', (0, 0), (0, 0), 1, colors.black),
                ('VALIGN', (0, 0), (0, 0), 'MIDDLE'),
            ]
        )
        Story.append(table)
        return Story

    def addTable(self, Story, Content):
        table = Table(
            self.TableFormater(Content), colWidths=[5 * cm, 10 * cm], hAlign="LEFT"
        )
        table.setStyle(
            TableStyle(
                [
                    ("INNERGRID", (0, 0), (-1, -1), 0.25, colors.black),
                    ("BOX", (0, 0), (-1, -1), 0.25, colors.black),
                ]
            )
        )
        Story.append(table)
        Story.append(Spacer(1, 1 * cm))
        return Story

    def addCode(self, Story, Content):
        Story.append(Spacer(1, 5))
        Story.append(Paragraph(Content, self.styles["ai_code"]))
        Story.append(Spacer(1, 5))
        return Story

    def addList(self, Story, Content):
        Story.append(Paragraph(Content, self.styles["ai_list"]))
        return Story

    def addOther(self, Story, Content):
        Story.append(Paragraph(Content, self.styles["ai_other"]))
        return Story

    def BuildExercice(self, Story, filename):
        data = LoadMDfile().readfile(filename)
        for tType, Content in data:
            if tType == "space":
                Story.append(Spacer(1, 12))
                continue
            if tType == "table":
                Story = self.addTable(Story, Content)
                continue
            if tType == "code":
                Story = self.addCode(Story, Content)
                continue
            if tType == "h1":
                Story = self.addH1(Story, Content)
                continue
            if tType == "h2":
                Story = self.addH2(Story, Content)
                continue
            if tType == "h3":
                Story = self.addH3(Story, Content)
                continue
            if tType == "list":
                Story = self.addList(Story, Content)
                continue
            if tType == "image":
                Story = self.addImage(Story, Content)
                continue
            Story = self.addOther(Story, Content)
        Story.append(PageBreak())
        return Story

    def SavePDF(self, Story):
        self.doc.build(
            Story,
            onFirstPage=PDFBuilder.BackGroundSetup,
            onLaterPages=PDFBuilder.BackGroundSetup,
        )

    def MetaData(self):
        self.doc.title = self.name + ".pdf"
        self.doc.author = "42-ai"
        self.doc.creator = "42-ai"
        self.doc.subject = "Python training exercices"
        self.doc.keywords = ["python", "42", "coding", "training"]

    def Build(self):

        self.MetaData()
        Story = []
        directory = self.name
        main_file = "{directory}/{name}.md".format(directory=directory, name=self.name)
        exercices = glob(directory + "/ex*/*.md")
        exercices.sort()
        Story = self.MainPage(Story, main_file)
        for file in exercices:
            Story = self.BuildExercice(Story, file)
        self.SavePDF(Story)


if __name__ == "__main__":
    for day in glob("day*"):
        if "." in day:
            continue
        pdf = PDFBuilder(day)
        pdf.Build()
