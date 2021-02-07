import os
import sys
import time
from concurrent.futures.process import ProcessPoolExecutor
from http import HTTPStatus
from typing import Optional

from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from rq import Queue
from rq.job import Job

from worker import conn, launch_session

q = Queue(connection=conn)

app = FastAPI(title="Title",
              version="1.0")

app.mount("/static", StaticFiles(directory="static"), name="static")


class params(BaseModel):
    target: Optional[str] = "M31"
    duration: Optional[float] = 180


@app.post("/createjob", status_code=HTTPStatus.ACCEPTED)
async def task_handler(item: params):
    job = q.enqueue(launch_session, item.target, item.duration, result_ttl=36000, job_timeout=50000)
    return {"status": job.get_status(), "uid": job.id}


@app.get("/jobs/{uid}")
async def status_handler(uid: str):
    job = Job.fetch(uid, connection=conn)
    with open(f'shared/{uid}.log', 'rb') as f:
        for line in f:
            pass
        last_line = line.decode("utf-8")
    last_update = last_line.split("|")
    if int(last_update[-1]) > 1:
        latest_image = f"/pictures/{uid}/{last_update[-1]}"
    else:
        latest_image = "None"

    return {"status": job.get_status(), "uid": job.id, "timestamp": last_update[0], "latest_command": last_update[2],
            "latest_image": latest_image}


@app.get("/pictures/{uid}/{id}", tags=['status'])
async def image_handler(uid: str, id: int):
    return FileResponse(f"static/{uid}_{id}")


@app.on_event("startup")
async def startup_event():
    app.state.executor = ProcessPoolExecutor()


@app.on_event("shutdown")
async def on_shutdown():
    app.state.executor.shutdown()
