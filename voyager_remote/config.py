import time
def optimal_telescope():
    from telescope_list import telescope_list
    tt = time.time()
    for i in telescope_list:
        telescope_list(object="M31", duration=180)
        HOST, PORT = telescope_list.closest_match()

    return HOST, PORT
