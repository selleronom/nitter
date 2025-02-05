--define:ssl
--define:useStdLib

# workaround httpbeast file upload bug
--assertions:off

# disable annoying warnings
warning("GcUnsafe2", off)
warning("ObservableStores", off)

const
  nimVersion = (major: NimMajor, minor: NimMinor, patch: NimPatch)

when nimVersion >= (1, 6, 0):
  warning("HoleEnumConv", off)
