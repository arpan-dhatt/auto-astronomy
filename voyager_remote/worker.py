import os
import sys, time
import redis
from rq import SimpleWorker, Queue, Connection, get_current_job
from telscopesession import TelscopeSession
global session
session = TelscopeSession()
listen = ['default']

redis_url = os.getenv('REDISTOGO_URL', 'redis://localhost:6379')

conn = redis.from_url(redis_url)


def launch_session(target, duration):
    job = get_current_job()
    session.connect(job.id)
    session.execute(session.telescope.RemoteSetupConnect())
    session.execute(session.telescope.RemoteSetDashboardMode())
    session.execute(session.telescope.RemoteGetSetupData())
    #target = session.execute(session.telescope.RemoteSearchTarget(target))
    #session.execute(session.telescope.RemotePointTarget(target[0]["RAJ2000"], target[0]["DECJ2000"]))
    session.execute(session.telescope.RemoteCameraShot(duration))
    for i in range(5):
        session.heartbeat()
        time.sleep(3)


if __name__ == '__main__':
    with Connection(conn):
        worker = SimpleWorker(map(Queue, listen))
        worker.work()
