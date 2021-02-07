import json
import base64
import socket
from json_parser import loads
import time
from config import HOST, PORT
import logging


class Telescope:
    def __init__(self, uid):
        self.uid = uid
        self.id = 0
        self.current_command = ""
        self.latest_image = -1
        logging.basicConfig(filename=f"shared/{self.uid}.log", level=logging.INFO,
                            format='%(asctime)s | %(levelname)s | %(message)s',
                            datefmt='%m/%d/%Y %I:%M:%S %p')

    def RemoteSetupConnect(self):
        self.id += 1
        self.current_command = "RemoteSetupConnect"
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteSetupConnect", "params": {"UID": self.uid, "TimeoutConnect": 90}, "id": self.id}

    def RemoteSetupDisconnect(self):
        self.id += 1
        self.current_command = "RemoteSetupDisconnect"
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteSetupDisconnect",
                "params": {"UID": self.uid, "TimeoutDisconnect": 90}, "id": self.id}

    def RemoteSearchTarget(self, target: str):
        self.current_command = "RemoteSearchTarget"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteSearchTarget",
                "params": {"UID": self.uid, "Name": f"{target}", "SearchType": 0}, "id": self.id}

    def RemoteGetSetupData(self):
        self.current_command = "RemoteGetSetupData"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteGetEnvironmentData", "params": {"UID": self.uid}, "id": self.id}

    def RemotePointTarget(self, ra: str, dec: str):
        self.current_command = "RemotePointTarget"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemotePrecisePointTarget",
                "params": {"UID": self.uid, "IsText": "true", "RA": 0, "DEC": 0,
                           "RAText": ra, "DECText": dec}, "id": self.id}

    def RemoteSequence(self):
        self.current_command = "RemoteSequence"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteSequence",
                "params": {"UID": self.uid, "SequenceFile": "TestUnguidedNoPlateSolve.s2q",
                           "StartFlag": 0}, "id": self.id}

    def RemoteMountFastCommand(self, action: str):
        self.current_command = "RemoteMountFastCommand"
        self.id += 1
        fast_actions = {"track on": 1,
                        "track off": 2,
                        "park": 3,
                        "unpark": 4,
                        "zenith": 5
                        }
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteMountFastCommand", "params": {"UID": self.uid, "CommandType": fast_actions[action]},
                "id": self.id}

    def RemoteSetDashboardMode(self):
        self.current_command = "RemoteSetDashboardMode"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteSetDashboardMode", "params": {"UID": self.uid, "IsOn": "true"},
                "id": self.id}

    def IsRemoteImageReady(self, j):
        try:
            if j["Event"] == "NewJPGReady":
                print("YAY")
                with open(f"static/{self.uid}_{self.id}.jpg", "wb") as fh:
                    s = j["Base64Data"]
                    s += (4 % len(s)) * "="
                    fh.write(base64.b64decode(s))
                    self.latest_image = self.id
        except KeyError:
            pass

    def RemoteCooling(self, temp: float = -5, warmup: str = "false"):
        self.current_command = "RemoteCooling"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteCooling",
                "params": {"UID": self.uid, "IsSetPoint": "true", "IsCoolDown": "false", "IsASync": "false",
                           "IsWarmup": warmup, "IsCoolerOFF": "false", "Temperature": temp}, "id": self.id}

    def RemoteFocusEx(self, mode: int = 4):
        self.current_command = "RemoteFocusEx"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteFocusEx",
                "params": {"UID": self.uid, "FocusMode": mode, "filtroFuocoIndex": 0, "IsWDMaxHFD": "false",
                           "WDMaxHFDLimit": 9.4, "IsRetryFocusOnWD": "true", "PreviousPosition": -1,
                           "StarRAJ2000Str": "11 22 32.123", "StarDECJ2000Str": "22 1104.123", "IsGoBack": "true",
                           "IsOnlyPointingStar": "false"}, "id": self.id}

    def RemoteCameraShot(self, length: float):
        self.current_command = "RemoteCameraShot"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteCameraShot",
                "params": {"UID": self.uid, "Expo": length, "Bin": 1, "IsROI": "false",
                           "ROITYPE": 0, "ROIX": 0, "ROIY": 0, "ROIDX": 0, "ROIDY": 0, "FilterIndex": 0, "ExpoType": 0,
                           "SpeedIndex": 0, "ReadoutIndex": 0, "IsSaveFile": "true",
                           "FitFileName": "%%fitdir%%\\TestShot_20190130_001330.fit", "Gain": 112, "Offset": 10},
                "id": self.id}

    def RemoteGetCCDTemperature(self):
        self.id += 1
        self.current_command = "RemoteGetCCDTemperature"
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteGetCCDTemperature", "params": {"UID": self.uid}, "id": self.id}

    def RemoteSetProfile(self):
        self.current_command = "RemoteSetProfile"
        self.id += 1
        logging.info(f"{self.current_command} | {self.id} | {self.latest_image}")
        return {"method": "RemoteSetProfile", "params": {"UID": self.uid, "FileName": "Default.v2y"}, "id": self.id}


class TelscopeSession:
    def __init__(self):
        self.host = HOST
        self.port = PORT

    def connect(self, uid):
        self.uid = uid
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.connect((self.host, self.port))
        self.send({"Event": "Initialize"})
        _version = self.receive()[0]
        self.host_name = _version["Host"]
        self.instance = _version["Inst"]
        self.telescope = Telescope(uid=self.uid)

    def execute(self, data):
        self.send(data)
        result = self.wait()
        return result

    def send(self, data):
        self.socket.sendall(bytes(json.dumps(data, sort_keys=True) + '\r\n', encoding="utf-8"))

    def receive(self):
        raw = self.socket.recv(100000000)
        if len(raw) > 1000:
            raw += b'"}'
        out = []
        try:
            for i in loads(raw):
                out.append(i)
        except:
            pass
        return out

    def heartbeat(self):
        self.send({"Event": "Polling", "Timestamp": time.time(), "Host": self.host_name, "Inst": self.instance})
        j = self.receive()
        for i in j:
            self.telescope.IsRemoteImageReady(i)
        return j

    def wait(self):
        while True:
            result = self.heartbeat()
            for j in result:
                try:
                    if j["Event"] == "RemoteActionResult":
                        return result
                except KeyError:
                    pass

    def end(self):
        self.send({"method": "disconnect", "id": 1})
        return


def launch_session(*args, **kwargs):
    session = TelscopeSession("421")
    session.connect()
    session.execute(session.telescope.RemoteSetupConnect())
    session.execute(session.telescope.RemoteSetDashboardMode())
    session.execute(session.telescope.RemoteGetSetupData())
    session.execute(session.telescope.RemoteMountFastCommand("zenith"))
    while True:
        session.heartbeat()
        time.sleep(3)