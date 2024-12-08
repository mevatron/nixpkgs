{
  lib,
  fetchFromGitHub,
  python3,
}:

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
    py-datastruct
  ];

  pythonImportsCheck = [ "bk7231tools" ];

  meta = {
    description = "Tools to interact with and analyze artifacts for BK7231 MCUs";
    homepage = "https://github.com/tuya-cloudcutter/bk7231tools";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ mevatron ];
    mainProgram = "bk7231tools";
  };
}
