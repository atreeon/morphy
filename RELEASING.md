# Releasing

This project publishes `morphy` and `morphy_annotation` to pub.dev using a GitHub Actions workflow triggered by tags.

1. Update the `version` fields in both `morphy/pubspec.yaml` and `morphy_annotation/pubspec.yaml`.
2. Commit and push the changes.
3. Tag the commit with the new version and push the tag, e.g.:
   ```bash
   git tag -a v1.4.1 -m "Release v1.4.1"
   git push origin v1.4.1
   ```
4. The `publish.yml` workflow will run tests and publish both packages automatically.
5. Check the Actions tab to confirm the release succeeded.
