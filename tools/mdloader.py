import re

HTML_TABS = "&nbsp;&nbsp;&nbsp;&nbsp;"


# TODO: add image <img src="https://github.com/Talasta/My42Cursus/blob/master/06_lem_in/.resources/esc-caper.gif" width="100%">

class LoadMDfile:
    def __init__(self):
        import re

        self.boolCode = False
        self.buffer_code = ""
        self.boolTable = False
        self.buffer_table = []
        self.functions = [
            (self.isSpace, self.addSpace),
            (self.isCode, self.addCode),
            (self.isInnerCode, self.addInnerCode),
            (self.isTable, self.addTable),
            (self.isH1, self.addH1),
            (self.isH2, self.addH2),
            (self.isH3, self.addH3),
            (self.isList, self.addList),
            (self.isImg, self.addImg),
            (self.isOther, self.addOther),
        ]

    def readfile(self, filename):
        with open(filename) as f:
            lines = f.readlines()

        data = []
        for line in lines:
            # Clean
            content, attr = LoadMDfile.get_content_attribute(line)
            # Markdown to html sanitizer
            content = LoadMDfile.md_to_html_sanitizer(content)
            # Check if has to stop table buffering
            if self.stoping_table(content):
                data = self.stopTable(data)
            # Find type and add content to the data list
            for _is, _add in self.functions:
                ret = _is(content, attr)
                if ret == True:
                    data = _add(data, content, attr)
                    break
        return data

    @staticmethod
    def md_to_html_sanitizer(string):
        string = string.replace("<br>", "<br/>")
        string = re.sub(r"\*\*(\S.*?\S)\*\*", "<b>\g<1></b>", string)
        string = re.sub(r"\*(\S.*?\S)\*", "<b>\g<1></b>", string)
        return string

    @staticmethod
    def get_content_attribute(string):
        string = string.strip("\n")
        attribute = string.split(" ")[0]
        return string, attribute

    @staticmethod
    def sanitize_code_highlight(string):
        string = re.sub(
            r"`(.*?)`",
            "<font name=Courier-Bold fontsize=11 textcolor=red>\g<1></font>",
            string,
        )
        return string

    def stoping_table(self, content):
        return (
            self.boolTable == True and (len(content) > 0 and content[0] == "|") == False
        )

    def stopTable(self, data):
        data.append(("table", self.buffer_table))
        self.buffer_table = []
        self.boolTable = False
        return data

    def isSpace(self, content, attr):
        return content == ""

    def addSpace(self, data, content, attr):
        data.append(("space", ""))
        return data
    
    def isImg(self, content, attr):
        return content == ""

    def addImg(self, data, content, attr):
        data.append(("image", content))
        return data

    def isCode(self, content, attr):
        return len(attr) >= 3 and attr[:3] == "```"

    def addCode(self, data, content, attr):
        if self.boolCode == True:
            data.append(("code", self.buffer_code))
            self.buffer_code = ""
            self.boolCode = False
        else:
            self.boolCode = True
        return data

    def isInnerCode(self, content, attr):
        return self.boolCode == True

    def addInnerCode(self, data, content, attr):
        content = content.replace("\t", HTML_TABS).replace("    ", HTML_TABS)
        self.buffer_code += content + "<br/>"
        return data

    def isTable(self, content, attr):
        return len(content) > 0 and content[0] == "|"

    def addTable(self, data, content, attr):
        self.boolTable = True
        tmp = content.strip("|").split("|")
        tmp = [val.strip() for val in tmp]
        if all(char in ":- " for char in "".join(tmp)):
            return data
        self.buffer_table.append(tmp)
        return data

    def isH1(self, content, attr):
        return attr == "#"

    def addH1(self, data, content, attr):
        data.append(("h1", content.strip("# ")))
        return data

    def isH2(self, content, attr):
        return attr == "##"

    def addH2(self, data, content, attr):
        data.append(("h2", content.strip("# ")))
        return data

    def isH3(self, content, attr):
        return attr == "###"

    def addH3(self, data, content, attr):
        data.append(("h3", content.strip("# ")))
        return data

    def isList(self, content, attr):
        return len(attr) == 1 and attr[0] == "*"

    def addList(self, data, content, attr):
        content = LoadMDfile.sanitize_code_highlight(content)
        data.append(("list", content.strip(" *")))
        return data

    def isOther(self, content, attr):
        return True

    def addOther(self, data, content, attr):
        content = LoadMDfile.sanitize_code_highlight(content)
        data.append(("other", content.strip(" ")))
        return data
