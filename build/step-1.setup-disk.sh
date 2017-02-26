

hdiutil create -ov -size 20m -type SPARSEBUNDLE -fs HFS+J -volname McRemote artefacts/McRemote

hdiutil mount artefacts/McRemote.sparsebundle

bless --folder /Volumes/McRemote --openfolder /Volumes/McRemote


mkdir /Volumes/McRemote/.background
cp McRemote.background.png /Volumes/McRemote/.background 

mkdir /Volumes/McRemote/McRemote.app

pushd /Volumes/McRemote/
ln -s /Applications
popd

echo run applescript now

