import json
import socket
import time

from config import HOST, PORT


class Telescope:
    def __init__(self, uid):
        self.uid = uid
        self.id = 0

    def RemoteSetupConnect(self):
        self.id += 1
        return {"method": "RemoteSetupConnect", "params": {"UID": self.uid, "TimeoutConnect": 90}, "id": self.id}

    def RemoteSetupDisconnect(self):
        self.id += 1
        return {"method": "RemoteSetupDisconnect",
                "params": {"UID": self.uid, "TimeoutDisconnect": 90}, "id": self.id}

    def RemoteSearchTarget(self, target: str):
        self.id += 1
        return {"method": "RemoteSearchTarget",
                "params": {"UID": self.uid, "Name": f"{target}", "SearchType": 0}, "id": self.id}

    def RemoteGetSetupData(self):
        self.id += 1
        return {"method": "RemoteGetEnvironmentData", "params": {"UID": self.uid}, "id": self.id}

    def RemotePointTarget(self, ra: str, dec: str):
        self.id += 1
        return {"method": "RemotePrecisePointTarget",
                "params": {"UID": self.uid, "IsText": "true", "RA": 0, "DEC": 0,
                           "RAText": ra, "DECText": dec}, "id": self.id}

    def RemoteSequence(self):
        self.id += 1
        return {"method": "RemoteSequence",
                "params": {"UID": self.uid, "SequenceFile": "TestUnguidedNoPlateSolve.s2q",
                           "StartFlag": 0}, "id": self.id}

    def RemoteMountFastCommand(self, action: str):
        self.id += 1
        fast_actions = {"track on": 1,
                        "track off": 2,
                        "park": 3,
                        "unpark": 4,
                        "zenith": 5
                        }
        return {"method": "RemoteMountFastCommand", "params": {"UID": self.uid, "CommandType": fast_actions[action]},
                "id": self.id}

    def RemoteSetDashboardMode(self):
        self.id += 1
        return {"method": "RemoteSetDashboardMode", "params": {"UID": self.uid, "IsOn": "true"},
                "id": self.id}

    def IsRemoteImageReady(self, j):
        try:
            if j["Event"] == "NewJPGReady":
                print("YAY")
                with open(f"{self.uid}_{self.id}.jpg", "wb") as fh:
                    fh.write(j["Base64Data"].decode('base64'))
        except Exception as e:
            print(str(e))
            pass

    def RemoteCooling(self, temp: float = -25, warmup: str = "false"):
        self.id += 1
        return {"method": "RemoteCooling",
                "params": {"UID": self.uid, "IsSetPoint": "true", "IsCoolDown": "false", "IsASync": "false",
                           "IsWarmup": warmup, "IsCoolerOFF": "false", "Temperature": temp}, "id": self.id}

    def RemoteFocusEx(self, mode: int = 4):
        self.id += 1
        return {"method": "RemoteFocusEx",
                "params": {"UID": self.uid, "FocusMode": mode, "filtroFuocoIndex": 0, "IsWDMaxHFD": "false",
                           "WDMaxHFDLimit": 9.4, "IsRetryFocusOnWD": "true", "PreviousPosition": -1,
                           "StarRAJ2000Str": "11 22 32.123", "StarDECJ2000Str": "22 1104.123", "IsGoBack": "true",
                           "IsOnlyPointingStar": "false"}, "id": self.id}

    def RemoteCameraShot(self, length: float):
        self.id += 1
        return {"method": "RemoteCameraShot",
                "params": {"UID": self.uid, "Expo": length, "Bin": 1, "IsROI": "false",
                           "ROITYPE": 0, "ROIX": 0, "ROIY": 0, "ROIDX": 0, "ROIDY": 0, "FilterIndex": 0, "ExpoType": 0,
                           "SpeedIndex": 0, "ReadoutIndex": 0, "IsSaveFile": "true",
                           "FitFileName": "%%fitdir%%\\TestShot_20190130_001330.fit", "Gain": 112, "Offset": 10},
                "id": self.id}

    def RemoteGetCCDTemperature(self):
        return {"method": "RemoteGetCCDTemperature", "params": {"UID": self.uid}, "id": self.id}


class TelscopeSession:
    def __init__(self, uid):
        self.uid = uid
        self.host = HOST
        self.port = PORT
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.connect((self.host, self.port))
        self.send({"Event": "Initialize"})
        _version = json.loads(self.receive())
        self.host_name = _version["Host"]
        self.instance = _version["Inst"]
        self.telescope = Telescope(uid=uid)

    def execute(self, data):
        self.send(data=data)
        result = self.wait()
        return result

    def send(self, data):
        self.socket.sendall(bytes(json.dumps(data, sort_keys=True) + '\r\n', encoding="utf-8"))

    def receive(self):
        return self.socket.recv(1000000000)

    def heartbeat(self):
        self.send({"Event": "Polling", "Timestamp": time.time(), "Host": self.host_name, "Inst": self.instance})
        j = self.receive()

        self.telescope.IsRemoteImageReady(json.loads(j))
        return j

    def end(self):
        self.send({"method": "disconnect", "id": 1})
        return

    def wait(self):
        j = json.loads(self.receive())
        while True:
            result = self.heartbeat()
            j = json.loads(result)
            if j["Event"] == "RemoteActionResult":
                break
        return result

    def sample_session(self, target="M31", num_exposures=5):
        session.execute(session.telescope.RemoteSetupConnect())
        session.execute(session.telescope.RemoteSetDashboardMode())
        session.execute(session.telescope.RemoteGetSetupData())
        session.execute(session.telescope.RemoteCooling())
        self.ccd_temp = json.loads(session.execute(session.telescope.RemoteGetCCDTemperature()))["ParamRet"]["CCDTemp"]
        # session.execute(session.telescope.RemoteFocusEx(mode=4))
        # target = json.loads(session.execute(session.telescope.RemoteSearchTarget(target)))
        # session.execute(session.telescope.RemotePointTarget(target["RAJ2000"], target["DECJ2000"]))
        session.execute(session.telescope.RemoteCameraShot(10))
        """
        for i in range(num_exposures):
            session.execute(session.telescope.RemoteCameraShot(180))
            if i % 5:
                session.execute(session.telescope.RemoteFocusEx(mode=2))
            self.ccd_temp = json.loads(session.execute(session.telescope.RemoteGetCCDTemperature()))["ParamRet"]["CCDTemp"]

        session.execute(session.telescope.RemoteCooling(warmup="true"))
        """
        # session.execute(session.telescope.RemoteMountFastCommand("park"))
        while True:
            session.heartbeat()
            time.sleep(3)


session = TelscopeSession("12s1")
session.sample_session()