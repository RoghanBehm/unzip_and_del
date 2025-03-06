# unzip_and_del

PowerShell utility script which extracts all zip files from a given source directory into the specified destination directory, then deletes all zip files in the source directory.

### Example usage
``.\extract.ps1 "C:\Users\Roghan\Downloads\zipped_dog_videos" "C:\Users\Roghan\Documents\dogs\videos"``

If a destination directory is not specified, the contents of the zipped files in the source directory will be extracted into that same directory. \
\
The following command would extract the contents of all files in Downloads to the Downloads folder, then delete all zip files in the Downloads directory: \
``.\extract.ps1 "C:\Users\Roghan\Downloads``

### Additional info 
If a zip file containing another zip file is extracted, the nested zip file will be extracted from its parent folder into the destination directory, but will not itself be extracted or deleted.
