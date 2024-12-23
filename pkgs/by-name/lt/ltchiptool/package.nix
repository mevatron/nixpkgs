{ lib, stdenv, fetchFromGitHub, platformio, python3, python3Packages }:

let
  libretiny-platform = fetchFromGitHub {
    owner = "libretiny-eu";
    repo = "libretiny";
    rev = "v1.7.0";
    hash = "sha256-xIcxmdTEG5WRJw/3c2DHh22+A+TcpQtgug8oDj4B1Oc=";
  };
in
python3Packages.buildPythonApplication rec {
  pname = "ltchiptool";
  version = "4.11.4";
  pyproject = true;

  # Fetch the source from GitHub
  src = fetchFromGitHub {
    owner = "libretiny-eu";
    repo = pname;
    rev = "v${version}"; # Matches the version tag
    hash = "sha256-VuvLHhrfYnrdZoMpkTOPF+Gj+Vro7Dwz/b9ZWFYn3ow=";
  };

  build-system = with python3.pkgs; [ poetry-core ];

  # Specify dependencies
  propagatedBuildInputs = with python3Packages; [
    bitstruct
    bk7231tools
    click
    colorama
    hexdump
    importlib-metadata
    platformio
    prettytable
    py-datastruct
    semantic-version
    requests
    wxpython
    xmodem
    zeroconf
    (if stdenv.hostPlatform.system == "aarch64-linux" || stdenv.hostPlatform.system == "armv7l-linux"
     then pyaes
     else pycryptodome)
  ];

  patches = [
    ./ltchiptool-fixes.patch
  ];

  # Add postInstall phase to copy platform data
  postInstall = ''
    mkdir -p $out/lib/python${python3.pythonVersion}/site-packages/ltchiptool/libretiny
    cp -r ${libretiny-platform}/* $out/lib/python${python3.pythonVersion}/site-packages/ltchiptool/libretiny
  '';

  # Add metadata
  meta = {
    description = "Universal flashing and binary manipulation tool for IoT chips";
    homepage = "https://github.com/libretiny-eu/ltchiptool";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ mevatron ];
  };
}
