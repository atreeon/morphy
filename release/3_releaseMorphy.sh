versionMorphyRaw=$(dart pub add morphy --dry-run)
versionMorphyPub=$(echo "$versionMorphyRaw" | grep -o '+ morphy [0-9.]*' | awk '{print $3}')
versionMorphyLocal=$(grep 'version:' "../morphy/pubspec.yaml" | awk '{print $2}')

versionAnnotationRaw=$(dart pub add morphy_annotation --dry-run)
versionAnnotationPub=$(echo "$versionAnnotationRaw" | grep -o '+ morphy_annotation [0-9.]*' | awk '{print $3}')
versionAnnotationLocal=$(grep 'version:' "../morphy_annotation/pubspec.yaml" | awk '{print $2}')

echo "Ready to upload Morphy version $versionMorphyLocal updating $versionMorphyPub"
echo "Ready to upload Annotation version $versionAnnotationLocal updating $versionAnnotationPub"

read -p "Is this correct? (y/n): " choice

if [ "$choice" = "y" ]; then
  clear
  echo "Continuing..."
else
  exit 0
fi

dart pub publish --dry-run --directory=../morphy

read -p "Do you want to publish morphy? (y/n): " choice
if [ "$choice" = "y" ]; then
  clear
  dart pub publish --directory=../morphy
else
  exit 0
fi

