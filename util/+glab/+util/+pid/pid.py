def is_running(pid):
    import ctypes
    kernel32 = ctypes.windll.kernel32
    SYNCHRONIZE = 0x100000

    process = kernel32.OpenProcess(SYNCHRONIZE, 0, pid)
    if process != 0:
        kernel32.CloseHandle(process)
        return True
    else:
        return False