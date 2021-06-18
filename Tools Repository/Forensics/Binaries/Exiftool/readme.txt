
- View file header contents

***
exiftool.exe c.jpg
***


- Extract image

***
exiftool.exe -a -b -W NEW/%f_%t%-c.%s -preview:all c.jpg
***


- Extract Binary Thumbnail

***
exiftool.exe c.jpg –b
***