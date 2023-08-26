# vasdolly_package_tools

A tools for vasdolly

## Getting Started

support windows, linux, macos

### Prerequisites


```bash
apksigner sign --v3-signing-enabled false  --ks $keyStore --ks-pass pass:$keyStore-pwd --ks-key-alias $alias --key-pass pass:$alias-pwd --out $sign_apk $input_apk
```

```bash
java -jar ./bin/Vasdolly.jar put -c $channel_file  $sign_apk $output_dir
```