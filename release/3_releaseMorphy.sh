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
  echo "Checking referenced morphy_annotation"
else
  exit 0
fi

versionMorphyAnnotation=$(grep 'morphy_annotation:' "../morphy/pubspec.yaml" | awk '{print $2}')
dependencyOverrides=$(grep 'dependency_overrides:' "../morphy/pubspec.yaml")
echo "Morphy references annotation version $versionMorphyAnnotation"
echo "morphy_annotation in pub.dev is $versionAnnotationPub"
echo "dependency_overrides should be commented out, is it? $dependencyOverrides"

read -p "Is this correct? (y/n): " choice

if [ "$choice" = "y" ]; then
  clear
  echo "publish dry run:"
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

read -p "Do you want to tag morphy as $versionMorphyLocal? (y/n): " choice
if [ "$choice" = "y" ]; then
  clear
  git tag "$versionMorphyLocal" -a
else
  exit 0
fi

echo "now please commit and push"
