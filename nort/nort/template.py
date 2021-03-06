from datetime import datetime

from nort.template import Template
from nort.note import SectionNotFoundException
from nort.nort import list_notes


def get_last_note(tags):
    notes = list_notes(cfg=Template.cfg, tags=tags)
    notes = list(filter(lambda x: x.created, notes))
    notes.sort(key=lambda x: x.created, reverse=True)

    notes = list(
        filter(
            lambda x: (
                datetime.today().replace(hour=0, minute=0, second=0, microsecond=0)
                - x.created.replace(hour=0, minute=0, second=0, microsecond=0)
            ).days
            > 0,
            notes,
        )
    )

    if not notes:
        return None

    return notes[0]


def last_todo(tags):
    note = get_last_note(tags)

    if not note:
        return "## TODO"

    try:
        return note.get_section("TODO")
    except SectionNotFoundException:
        return "## TODO"


class Diary(Template):
    def get_name(self):
        return "Diary_[[DATE]]"

    def get_tags(self):
        return ["diary", "todo", "[[DATE]]"]

    def get_content(self):
        return "\n".join(
            [
                "# [[DATE]]",
                "",
                last_todo(["diary", "todo"]),
            ]
        )


class Work(Template):
    def __init__(self, job="Work"):
        super().__init__()
        self.job = job

    def get_name(self):
        return f"{self.job}_[[DATE]]"

    def get_tags(self):
        return ["work", self.job.lower(), "[[DATE]]", "todo", "daybook"]

    def get_content(self):
        return "\n".join(
            [
                f"# {self.job} on [[DATE]]",
                "",
                "| started | finished | break |",
                "|---------|----------|-------|",
                "| [[TIME]]| TODO     | TODO  |",
                "",
                last_todo(["work", "todo", self.job.lower(), "daybook"]),
            ]
        )


class SCC(Work):
    def __init__(self):
        super().__init__("SCC")


class FZI(Work):
    def __init__(self):
        super().__init__("FZI")
