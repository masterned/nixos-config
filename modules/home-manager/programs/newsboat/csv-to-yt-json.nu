def main [csv_file] {
  open $csv_file | update tags {|row|
    $row.tags + ":youtube"
  } | update tags {|row|
    $row.tags | split row ':'
  } | update id {|row|
    $row.id | "https://www.youtube.com/feeds/videos.xml?channel_id=" + $in
  } | rename --column {id: url} | sort-by title --ignore-case | to json
}
