{ stdenv
, hyprcursor
, color ? "#191724"
}:

stdenv.mkDerivation {
  pname = "rose-pine-hyprcursor";
  version = "1.0.0";
  src = ./.;

  dontConfigure = true;

  nativeBuildInputs = [ hyprcursor ];

  buildPhase = ''
    runHook preBuild

    mkdir -p "$out"/share/icons
    sed -i 's/#191724/${color}/g' hyprcursors/**/*.svg
    hyprcursor-util -c . -o "$out"/share/icons

    runHook postBuild
  '';
}
