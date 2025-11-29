{
  lib,
  python3Packages,
  fetchFromGitHub,
  makeWrapper,
}:

python3Packages.buildPythonApplication rec {
  pname = "bitpoll";
  version = "0.9.2";
  format = "other";

  src = fetchFromGitHub {
    owner = "fsinfuhh";
    repo = "Bitpoll";
    rev = version;
    hash = "sha256-5tFCMAxr739oDdEpT9FYJjI1EvXLfKvRZu8vq+0YQkE=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = [ makeWrapper ];

  propagatedBuildInputs = with python3Packages; [
#    django_5
    asgiref
    bleach
    caldav
    certifi
    cffi
    charset-normalizer
    cryptography
    django-encrypted-model-fields
    #django-markdownify
    #django-pipeline
    django-widget-tweaks
    icalendar
    idna
    libsass
    lxml
    markdown
    pycparser
    python-dateutil
    pytz
    requests
    six
    sqlparse
    tinycss2
    typing-extensions
    tzlocal
    urllib3
    vobject
    webencodings
    ];

    installPhase = ''
      # Copy source code 
      mkdir -p $out/share/bitpoll
      cp -r . $out/share/bitpoll

      localConf="$out/share/bitpoll/bitpoll/settings_local.py"

    echo "import os" > $localConf
    echo "SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY', 'dummy-key-for-build')" >> $localConf
    echo "DEBUG = True" >> $localConf
    echo "ALLOWED_HOSTS = ['*']" >> $localConf
    echo "BASE_URL = 'http://localhost:8000'" >> $localConf
    echo "INSTALLED_APPS_LOCAL = []" >> $localConf
    echo "MIDDLEWARE_LOCAL = []" >> $localConf
    echo "PIPELINE_LOCAL = {}" >> $localConf 
echo "LOGGING_LOCAL = {}" >> $localConf
    echo "TEMPLATES_LOCAL = []" >> $localConf

    echo "DATABASES = { 'default': { 'ENGINE': 'django.db.backends.sqlite3', 'NAME': '/tmp/bitpoll.sqlite3', } }" >> $localConf

      # Create binary
      mkdir -p $out/bin
      # Create Wrapper
      makeWrapper ${python3Packages.python.interpreter} $out/bin/bitpoll \
      --add-flags "$out/share/bitpoll/manage.py runserver 0.0.0.0:8000" \
      --chdir "$out/share/bitpoll" \
      --prefix PYTHONPATH : "$PYTHONPATH:$out/share/bitpoll"
    '';

  meta = {
    description = "A web application for scheduling meetings and general polling";
    homepage = "https://github.com/fsinfuhh/Bitpoll";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "bitpoll";
    platforms = lib.platforms.all;
  };
}
