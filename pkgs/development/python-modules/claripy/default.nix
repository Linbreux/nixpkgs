{ lib
, buildPythonPackage
, setuptools
, cachetools
, decorator
, fetchFromGitHub
, future
, pysmt
, pythonOlder
, pytestCheckHook
, z3
}:

buildPythonPackage rec {
  pname = "claripy";
  version = "9.2.39";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "angr";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-Qr/wyaa5vDWd/0TEn9utdeaq6SINtopd49LuQddECvw=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    cachetools
    decorator
    future
    pysmt
    z3
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    # Use upstream z3 implementation
    substituteInPlace setup.cfg \
      --replace "z3-solver==4.10.2.0" ""
  '';

  pythonImportsCheck = [
    "claripy"
  ];

  meta = with lib; {
    description = "Python abstraction layer for constraint solvers";
    homepage = "https://github.com/angr/claripy";
    license = with licenses; [ bsd2 ];
    maintainers = with maintainers; [ fab ];
  };
}
