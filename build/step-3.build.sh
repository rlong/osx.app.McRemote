


if [ $# != 1 ]
then
#    echo "[build.sh] must be invoked with a provisioning profile"
#    echo "[build.sh] for example: ./build.sh  \"rlong / com.github.rlong.* / deployment\"";
#    exit 1
fi

# export PROVISIONING_PROFILE="rlong / com.github.rlong.* / deployment"
export PROVISIONING_PROFILE=$1


xcodebuild clean -workspace ../osx.app.McRemote.xcworkspace -scheme "McRemote" -configuration Release 
# xcodebuild clean -workspace ../osx.app.McRemote.xcworkspace -configuration Release -alltargets
## xcodebuild archive -workspace ../CentreApp-iOS.xcworkspace -scheme Centre -arch armv7 -archivePath artefacts/$FLAVOUR.xcarchive
#xcodebuild archive -workspace ../CentreApp-iOS.xcworkspace -scheme Centre -archivePath artefacts/$FLAVOUR.xcarchive
# xcodebuild archive  -project ../osx.app.Mc_Remote.xcodeproj -list
xcodebuild archive  -workspace ../osx.app.McRemote.xcworkspace -scheme "McRemote" -archivePath artefacts/McRemote.xcarchive

# cp -f artefacts/osx.app.Mc_Remote.xcarchive/Products/Applications/Mc\ Remote.app ~/Applications
#
#if [ -f artefacts/$FLAVOUR.ipa ]
#then
#    rm artefacts/$FLAVOUR.ipa
#fi

xcodebuild -exportArchive -archivePath artefacts/$FLAVOUR.xcarchive -exportPath artefacts/$FLAVOUR.ipa -exportFormat ipa -exportProvisioningProfile "$PROVISIONING_PROFILE"


# clean up the `xcarchive`

#if [ -d "artefacts/$FLAVOUR.xcarchive" ]
#then
#    rm -r artefacts/$FLAVOUR.xcarchive
#fi
