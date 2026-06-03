from pydantic import BaseModel
from typing import List

class ResumeRequest(BaseModel):
    name: str
    skills: List[str]