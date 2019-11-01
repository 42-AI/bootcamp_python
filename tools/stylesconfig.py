from reportlab.lib.enums import TA_JUSTIFY, TA_CENTER, TA_LEFT
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import cm

styles = getSampleStyleSheet()

styles.add(
    ParagraphStyle(
        name="ai_other", parent=styles["Normal"], fontSize=11
    )
)
styles.add(
    ParagraphStyle(
        name="ai_list",
        parent=styles["Normal"],
        fontSize=11,
        bulletText="•",
        bulletFontSize=11,
    )
)
styles.add(
    ParagraphStyle(
        name="main_title",
        parent=styles["Normal"],
        leading=30,
        alignment=TA_CENTER,
        fontSize=40,
        fontName="Helvetica-Bold",
    )
)
styles.add(
    ParagraphStyle(
        name="ai_h1",
        parent=styles["Normal"],
        leading=30,
        alignment=TA_CENTER,
        fontSize=30,
        fontName="Helvetica-Bold",
    )
)
styles.add(
    ParagraphStyle(
        name="ai_h2",
        parent=styles["Normal"],
        leading=20,
        alignment=TA_LEFT,
        fontSize=20,
        fontName="Helvetica-Bold",
    )
)
styles.add(
    ParagraphStyle(
        name="ai_h3",
        parent=styles["Normal"],
        leading=20,
        alignment=TA_LEFT,
        fontSize=14,
        fontName="Helvetica-Bold",
    )
)
styles.add(
    ParagraphStyle(
        name="ai_code",
        parent=styles["Normal"],
        fontName="Courier",
        backColor="black",
        textColor="white",
        borderPadding=0.1 * cm,
    )
)
