
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

cd ../morphy
dart pub get
dart pub run test
cd ../release

read -p "Did the tests pass? (y/n): " choice
if [ "$choice" = "y" ]; then
  clear
  echo "Continuing..."
else
  exit 0
fi

cd ../example
dart pub get
dart run build_runner build --delete-conflicting-outputs
dart pub run test
cd ../release

read -p "Did the tests pass? (y/n): " choice
if [ "$choice" = "y" ]; then
  clear
  echo "Continuing..."
else
  exit 0
fi

dart pub publish --dry-run --directory=../morphy_annotation

read -p "Annotation Ready? (y/n): " choice
if [ "$choice" = "y" ]; then
  clear
  echo "All ready to upload..."
else
  exit 0
fi

dart pub publish --dry-run --directory=../morphy

read -p "Morphy Ready? (y/n): " choice
if [ "$choice" = "y" ]; then
  clear
  echo "All ready to upload..."
else
  exit 0
fi

