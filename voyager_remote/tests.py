import os

uid = "903a2996-63ef-4e8e-91c1-935b4a9d0f3a"

def func(uid):
    with open(f'shared/{uid}.log', 'rb') as f:
        for line in f:
            pass
        last_line = line.decode("utf-8")
    last_update = last_line.split("|")
    if int(last_update[-1]) > 1:
        latest_image = f"/pictures/{uid}/{last_update[-1]}"
    else:
        latest_image = "None"

    return {"timestamp": last_update[0], "latest_command": last_update[2],
            "latest_image": latest_image}

print(func(uid))