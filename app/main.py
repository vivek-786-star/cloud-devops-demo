from fastapi import FastAPI
# from models import ResumeRequest
# from services import calculate_score
# from logger import logger
from .models import ResumeRequest
from .services import calculate_score
from .logger import logger
from datetime import datetime

app = FastAPI(
    title="Cloud DevOps Demo API",
    version="1.0.0"
)

START_TIME = datetime.utcnow()

@app.get("/")
def home():
    return {
        "message": "Cloud DevOps Demo API",
        "version": "1.0.0"
    }

@app.get("/health")
def health():

    return {
        "status": "UP"
    }

@app.get("/metrics")
def metrics():

    uptime = datetime.utcnow() - START_TIME

    return {
        "uptime_seconds": uptime.total_seconds(),
        "service": "resume-api"
    }

@app.post("/resume-score")
def resume_score(request: ResumeRequest):

    score, recommendation = calculate_score(
        request.skills
    )

    logger.info(
        f"{request.name} evaluated with score {score}"
    )

    return {
        "candidate": request.name,
        "score": score,
        "recommendation": recommendation
    }