{
  lib,
  fetchFromGitHub,
  python3,
}:

let
  pyDatastruct = python3.pkgs.buildPythonPackage rec {
    pname = "py-datastruct";
    version = "1.1.0"; # Latest appears to be 2.0.0, but bk7231tools depends on 1.x
    pyproject = true;

    src = fetchFromGitHub {
      owner = "kuba2k2";
      repo = "datastruct";
      rev = "refs/tags/v${version}";
      hash = "sha256-KEIvibGnQnIDMpmodWN2Az/ypc37ZyGvgVPC7voFmlA=";
    };

    build-system = with python3.pkgs; [ poetry-core ];

    pythonImportsCheck = [ "datastruct" ];

    meta = with lib; {
      description = "Combination of struct and dataclasses for easy parsing of binary formats";
      homepage = "https://github.com/kuba2k2/datastruct";
      license = licenses.mit;
      maintainers = with maintainers; [ mevatron ];
    };
  };
in

python3.pkgs.buildPythonApplication rec {
  pname = "bk7231tools";
  version = "2.0.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tuya-cloudcutter";
    repo = "bk7231tools";
    rev = "refs/tags/v${version}";
    hash = "sha256-Ag63VNBSKEPDaxhS40SVB8rKIJRS1IsrZ9wSD0FglSU=";
  };

  pythonRelaxDeps = [
    "pyserial"
    "pycryptodome"
    "py-datastruct"
  ];

  build-system = with python3.pkgs; [ poetry-core ];

  dependencies = with python3.pkgs; [
    pyserial
    pycryptodome
    pyDatastruct
  ];

  pythonImportsCheck = [ "bk7231tools" ];

  meta = with lib; {
    description = "Tools to interact with and analyze artifacts for BK7231 MCUs";
    homepage = "https://github.com/tuya-cloudcutter/bk7231tools";
    license = licenses.mit;
    maintainers = with maintainers; [ mevatron ];
    mainProgram = "bk7231tools";
  };
}
