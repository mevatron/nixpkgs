{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core
}:

buildPythonPackage rec {
  pname = "py-datastruct";
  version = "1.1.0"; # Latest appears to be 2.0.0, but bk7231tools depends on 1.x
  pyproject = true;

  src = fetchFromGitHub {
    owner = "kuba2k2";
    repo = "datastruct";
    rev = "refs/tags/v${version}";
    hash = "sha256-KEIvibGnQnIDMpmodWN2Az/ypc37ZyGvgVPC7voFmlA=";
  };

  build-system = [ poetry-core ];

  pythonImportsCheck = [ "datastruct" ];

  meta = {
    description = "Combination of struct and dataclasses for easy parsing of binary formats";
    homepage = "https://github.com/kuba2k2/datastruct";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ mevatron ];
  };
}
