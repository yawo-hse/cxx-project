#!/usr/bin/python3

import os, sys

def parse_argv():
  args = dict()
  args['py'] = 'python3'
  args['generator'] = ''
  args['config'] = 'Release'
  args['msvc-runtime'] = 'MultiThreaded'
  
  if sys.platform == 'win32':
    args['py'] = 'python'

  argv = sys.argv

  for i, arg in enumerate(argv):
    if arg == '--generator':
      args['generator'] = argv[i+1]
    elif arg == '--config':
      args['config'] = argv[i+1]
    elif arg == '--use-python-alias':
      args['py'] = argv[i+1]
    elif arg == '--msvc-runtime':
      args['msvc-runtime'] = argv[i+1]

  return args

args = parse_argv()
cmd = ''
gen = ''
cfg = 'Release'
msvc_runtime = 'MultiThreaded'

if len(args['generator']) > 0:
  gen = ' -G "' + args['generator'] + '"'
  cmd = cmd + ' --generator ' + args['generator']
if len(args['config']) > 0:
  cfg = args['config']
  cmd = cmd + ' --config ' + args['config']
if len(args['msvc-runtime']) > 0:
  msvc_runtime = args['msvc-runtime']
  cmd = cmd + ' --msvc-runtime ' + args['msvc-runtime']

os.chdir('tools')

os.system(args['py'] + ' build-deps.py' + cmd)

os.chdir('..')

print('[ Build Project ]')
print('', flush=True)

if not os.path.exists('build'):
  os.mkdir('build')

os.system(
  'cmake' + gen +
  ' -D CMAKE_MSVC_RUNTIME_LIBRARY=' + msvc_runtime +
  ' -B build -S .')

os.system('cmake --build build --config ' + cfg)

print('')
