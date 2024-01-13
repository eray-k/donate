$source = ".\lib"
$dest = ".\test"
robocopy $source $dest /e /xf *.*
