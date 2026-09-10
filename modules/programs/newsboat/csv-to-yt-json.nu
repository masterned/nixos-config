def main [csv_file: path] {
  open $csv_file
    | update tags {|row| $row.tags | split row ':' | append youtube }
    | update id {|row| $"https://www.youtube.com/feeds/videos.xml?channel_id=($row.id)" }
    | rename --column {id: url}
    | sort-by title --ignore-case
    | to json
}
