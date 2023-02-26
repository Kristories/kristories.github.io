---
layout: post
title:  "Encoding to Base 64 with UTF-8 Character Set in Bash"
---

Base 64 encoding is a common technique used for data encoding and transmission. It converts binary data into a format that can be safely transmitted over communication channels that are not 8-bit clean, such as email or HTTP. In Bash, encoding to Base 64 with the UTF-8 character set is a straightforward process.

### The `base64` Command
The `base64` command is a built-in utility in Bash that encodes or decodes data in Base 64 format. It supports several options that allow you to customize the encoding process, including `-w` to specify the maximum line width and `-i` and `-o` to specify the input and output files, respectively.

### Encoding UTF-8 Text to Base 64
To encode UTF-8 text to Base 64 in Bash, you can use the `echo` command to pipe the text to the `base64` command. Here's an example:

```bash
echo "Hello, World!" | base64
```

This will output the Base 64 encoded text:

```
SGVsbG8sIFdvcmxkIQ==
```

The `echo` command outputs the text "Hello, World!", which is piped to the `base64` command. The `base64` command then encodes the text in Base 64 and outputs it to the console.

### Encoding UTF-8 Files to Base 64
To encode a UTF-8 file to Base 64 in Bash, you can use the `-w` and `-i` options of the `base64` command. Here's an example:

```bash
base64 -w 0 -i input.txt -o output.txt
```

This command encodes the contents of the `input.txt` file to Base 64 and writes the output to the `output.txt` file. The `-w 0` option specifies that the output should not be split into multiple lines, and the `-i` and `-o` options specify the input and output files, respectively.

### Conclusion
Base 64 encoding with the UTF-8 character set is a simple and effective way to encode binary data for transmission over communication channels that are not 8-bit clean. In Bash, the `base64` command provides a built-in utility for encoding data in Base 64 format. Whether you're encoding text or files, the `base64` command is a reliable tool for encoding data in a format that can be safely transmitted over the internet.