# RB-RC4

The `RC4Stream` class implements the [RC4 stream cipher](https://en.wikipedia.org/wiki/RC4). RC4 is vulnerable to several forms of attack and generally
should not be used to secure important data. In particular there is no authentication provided. ***Use at your own risk.***

The `RC4Stream.RandomBytes()` method returns the specified number of bytes from the RC4 key stream. 

The `RC4Stream.Process()` method combines the user-provided bytes with an equal number of bytes from the key stream, performing
both encryption and decryption.

The `RC4Stream.Offset` property gets and sets the position in the key stream.

## Example
Encrypt and decrypt a message:
```vbnet
  Dim message As String = "Attack at dawn!"
  Dim key As String = "seekrit"
  Dim rc4 As New RC4Stream(key)
  Dim ciphertxt As MemoryBlock = rc4.Process(message) ' encrypt
  rc4.Offset = 0 ' reset for decryption
  Dim cleartxt As String = rc4.Process(ciphertxt) ' decrypt
```

Generate random bytes:
```vbnet
  Dim key As String = "seekrit"
  Dim rc4 As New RC4Stream(key)
  Dim rand As MemoryBlock = rc4.RandomBytes(64) ' generate 64 pseudo-random bytes
```
