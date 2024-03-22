;extends

(annotation
  name:  (identifier) @name (#eq? @name "Query")
  arguments: (annotation_argument_list
    [
      (element_value_pair
        key: (identifier) @value (#eq? @value "value")
        value: (string_literal [(multiline_string_fragment) (string_fragment)] @injection.content))
      (string_literal [(multiline_string_fragment) (string_fragment)] @injection.content)
    ]
  )
  (#set! injection.language "sql")
)
