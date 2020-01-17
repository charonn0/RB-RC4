#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  RunTests()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub RunTests()
		  ' These tests use the RC4 test vectors from https://tools.ietf.org/html/rfc6229
		  
		  If Not Test40Bits() Then Break
		  If Not Test56Bits() Then Break
		  If Not Test64Bits() Then Break
		  If Not Test80Bits() Then Break
		  If Not Test128Bits() Then Break
		  If Not Test192Bits() Then Break
		  If Not Test256Bits() Then Break
		  If Not Test40BitsAlt() Then Break
		  
		  MsgBox("Tests complete")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test(Context As RC4Stream, TestVector As MemoryBlock) As Boolean
		  For i As Integer = 0 To TestVector.Size - 1
		    Dim rr As MemoryBlock = Context.RandomBytes(1)
		    Dim template As Int8 = TestVector.Int8Value(i)
		    Dim response As Int8 = rr.Int8Value(0)
		    If template <> response Then
		      Return False
		    End If
		  Next
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test128Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("0102030405060708090a0b0c0d0e0f10"))
		  
		  Const offset0 = "9ac7cc9a609d1ef7b2932899cde41b975248c4959014126a6e8a84f11d1a9e1c"
		  Const offset240 = "065902e4b620f6cc36c8589f66432f2bd39d566bc6bce3010768151549f3873f"
		  Const offset496 = "b6d1e6c4a5e4771cad79538df295fb11c68c1d5c559a974123df1dbc52a43b89"
		  Const offset752 = "c5ecf88de897fd57fed301701b82a259eccbe13de1fcc91c11a0b26c0bc8fa4d"
		  Const offset1008 = "e7a72574f8782ae26aabcf9ebcd66065bdf0324e6083dcc6d3cedd3ca8c53c16"
		  Const offset1520 = "b40110c4190b5622a96116b0017ed297ffa0b514647ec04f6306b892ae661181"
		  Const offset2032 = "d03d1bc03cd33d70dff9fa5d71963ebd8a44126411eaa78bd51e8d87a8879bf5"
		  Const offset3056 = "fabeb76028ade2d0e48722e46c4615a3c05d88abd50357f935a63c59ee537623"
		  Const offset4080 = "ff38265c1642c1abe8d3c2fe5e572bf8a36a4c301ae8ac13610ccbc12256cacc"
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test192Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("0102030405060708090a0b0c0d0e0f101112131415161718"))
		  
		  Const offset0 = "0595e57fe5f0bb3c706edac8a4b2db11dfde31344a1af769c74f070aee9e2326"
		  Const offset240 = "b06b9b1e195d13d8f4a7995c4553ac056bd2378ec341c9a42f37ba79f88a32ff"
		  Const offset496 = "e70bce1df7645adb5d2c4130215c35229a5730c7fcb4c9af51ffda89c7f1ad22"
		  Const offset752 = "0485055fd4f6f0d963ef5ab9a5476982591fc66bcda10e452b03d4551f6b62ac"
		  Const offset1008 = "2753cc83988afa3e1688a1d3b42c9a0293610d523d1d3f0062b3c2a3bbc7c7f0"
		  Const offset1520 = "96c248610aadedfeaf8978c03de8205a0e317b3d1c73b9e9a4688f296d133a19"
		  Const offset2032 = "bdf0e6c3cca5b5b9d533b69c56ada12088a218b6e2ece1e6246d44c759d19b10"
		  Const offset3056 = "6866397e95c140534f94263421006e4032cb0a1e9542c6b3b8b398abc3b0f1d5"
		  Const offset4080 = "29a0b8aed54a132324c62e423f54b4c83cb0f3b5020a98b82af9fe154484a168"
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test256Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20"))
		  
		  Const offset0 = "eaa6bd25880bf93d3f5d1e4ca2611d91cfa45c9f7e714b54bdfa80027cb14380"
		  Const offset240 = "114ae344ded71b35f2e60febad727fd802e1e7056b0f623900496422943e97b6"
		  Const offset496 = "91cb93c787964e10d9527d999c6f936b49b18b42f8e8367cbeb5ef104ba1c7cd"
		  Const offset752 = "87084b3ba700bade955610672745b374e7a7b9e9ec540d5ff43bdb12792d1b35"
		  Const offset1008 = "c799b596738f6b018c76c74b1759bd907fec5bfd9f9b89ce6548309092d7e958"
		  Const offset1520 = "40f250b26d1f096a4afd4c340a5888153e34135c79db010200767651cf263073"
		  Const offset2032 = "f656abccf88dd827027b2ce917d464ec18b62503bfbc077fbabb98f20d98ab34"
		  Const offset3056 = "8aed95ee5b0dcbfbef4eb21d3a3f52f9625a1ab00ee39a5327346bddb01a9c18"
		  Const offset4080 = "a13a7c79c7e119b5ab0296ab28c300b9f3e4c0a2e02d1d01f7f0a74618af2b48"
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test40Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("0102030405"))
		  
		  Const offset0 = "b2396305f03dc027ccc3524a0a1118a86982944f18fc82d589c403a47a0d0919"
		  Const offset240 = "28cb1132c96ce286421dcaadb8b69eae1cfcf62b03eddb641d77dfcf7f8d8c93"
		  Const offset496 = "42b7d0cdd918a8a33dd51781c81f40416459844432a7da923cfb3eb4980661f6"
		  Const offset752 = "ec10327bde2beefd18f9277680457e22eb62638d4f0ba1fe9fca20e05bf8ff2b"
		  Const offset1008 = "45129048e6a0ed0b56b490338f078da530abbcc7c20b01609f23ee2d5f6bb7df"
		  Const offset1520 = "3294f744d8f9790507e70f62e5bbceead8729db41882259bee4f825325f5a130"
		  Const offset2032 = "1eb14a0c13b3bf47fa2a0ba93ad45b8bcc582f8ba9f265e2b1be9112e975d2d7"
		  Const offset3056 = "f2e30f9bd102ecbf75aaade9bc35c43cec0e11c479dc329dc8da7968fe965681"
		  Const offset4080 = "068326a2118416d21f9d04b2cd1ca050ff25b58995996707e51fbdf08b34d875"
		  
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test40BitsAlt() As Boolean
		  Dim r As New RC4Stream(DecodeHex("833222772a"))
		  
		  Const offset0 = "80ad97bdc973df8a2e879e92a497efda20f060c2f2e5126501d3d4fea10d5fc0"
		  Const offset240 = "faa148e99046181fec6b2085f3b20ed9f0daf5bab3d596839857846f73fbfe5a"
		  Const offset496 = "1c7e2fc4639232fe297584b296996bc83db9b249406cc8edffac55ccd322ba12"
		  Const offset752 = "e4f9f7e0066154bbd125b745569bc89775d5ef262b44c41a9cf63ae14568e1b9"
		  Const offset1008 = "6da453dbf81e82334a3d8866cb50a1e37828d074119cab5c22b294d7a9bfa0bb"
		  Const offset1520 = "adb89cea9a15fbe617295bd04b8ca05c6251d87fd4aaae9a7e4ad5c217d3f300"
		  Const offset2032 = "e7119bd6dd9b22afe8f89585432881e2785b60fd7ec4e9fcb6545f350d660fab"
		  Const offset3056 = "afecc037fdb7b0838eb3d70bcd268382dbc1a7b49d57358cc9fa6d61d73b7cf0"
		  Const offset4080 = "6349d126a37afcba89794f9804914fdcbf42c3018c2f7c66bfde524975768115"
		  
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test56Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("01020304050607"))
		  
		  Const offset0 = "293f02d47f37c9b633f2af5285feb46be620f1390d19bd84e2e0fd752031afc1"
		  Const offset240 = "914f02531c9218810df60f67e338154cd0fdb583073ce85ab83917740ec011d5"
		  Const offset496 = "75f81411e871cffa70b90c74c592e4540bb87202938dad609e87a5a1b079e5e4"
		  Const offset752 = "c2911246b612e7e7b903dfeda1dad86632828f91502b6291368de8081de36fc2"
		  Const offset1008 = "f3b9a7e3b297bf9ad804512f9063eff18ecb67a9ba1f55a5a067e2b026a3676f"
		  Const offset1520 = "d2aa902bd42d0d7cfd340cd45810529f78b272c96e42eab4c60bd914e39d06e3"
		  Const offset2032 = "f4332fd31a079396ee3cee3f2a4ff04905459781d41fda7f30c1be7e1246c623"
		  Const offset3056 = "adfd3868b8e51485d5e610017e3dd609ad26581c0c5be45f4cea01db2f3805d5"
		  Const offset4080 = "f3172ceffc3b3d997c85ccd5af1a950ce74b0b9731227fd37c0ec08a47ddd8b8"
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test64Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("0102030405060708"))
		  
		  Const offset0 = "97ab8a1bf0afb96132f2f67258da15a88263efdb45c4a18684ef87e6b19e5b09"
		  Const offset240 = "9636ebc9841926f4f7d1f362bddf6e18d0a990ff2c05fef5b90373c9ff4b870a"
		  Const offset496 = "73239f1db7f41d80b643c0c52518ec63163b319923a6bdb4527c626126703c0f"
		  Const offset752 = "49d6c8af0f97144a87df21d91472f96644173a103b6616c5d5ad1cee40c863d0"
		  Const offset1008 = "273c9c4b27f322e4e716ef53a47de7a4c6d0e7b226259fa9023490b26167ad1d"
		  Const offset1520 = "1fe8986713f07c3d9ae1c163ff8cf9d38369e1a965610be887fbd0c79162aafb"
		  Const offset2032 = "0a0127abb44484b9fbef5abcae1b579fc2cdadc6402e8ee866e1f37bdb47e42c"
		  Const offset3056 = "26b51ea37df8e1d6f76fc3b66a7429b3bc7683205d4f443dc1f29dda3315c87b"
		  Const offset4080 = "d5fa5a3469d29aaaf83d23589db8c85b3fb46e2c8f0f068edce8cdcd7dfc5862"
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test80Bits() As Boolean
		  Dim r As New RC4Stream(DecodeHex("0102030405060708090a"))
		  
		  Const offset0 = "ede3b04643e586cc907dc2185170990203516ba78f413beb223aa5d4d2df6711"
		  Const offset240 = "3cfd6cb58ee0fdde640176ad0000044d48532b21fb6079c9114c0ffd9c04a1ad"
		  Const offset496 = "3e8cea98017109979084b1ef92f99d86e20fb49bdb337ee48b8d8dc0f4afeffe"
		  Const offset752 = "5c2521eacd7966f15e056544bea0d315e067a7031931a246a6c3875d2f678acb"
		  Const offset1008 = "a64f70af88ae56b6f87581c0e23e6b08f449031de312814ec6f319291f4a0516"
		  Const offset1520 = "bdae85924b3cb1d0a2e33a30c6d795998a0feddbac865a09bcd127fb562ed60a"
		  Const offset2032 = "b55a0a5b51a12a8be34899c3e047511ad9a09cea3ce75fe39698070317a71339"
		  Const offset3056 = "552225ed1177f44584ac8cfa6c4eb5fc7e82cbabfc95381b080998442129c2f8"
		  Const offset4080 = "1f135ed14ce60a91369d2322bef25e3c08b6be45124a43e2eb77953f84dc8553"
		  
		  r.Offset = 3056
		  If Not Test(r, DecodeHex(offset3056)) Then Return False
		  
		  r.Offset = 4080
		  If Not Test(r, DecodeHex(offset4080)) Then Return False
		  
		  r.Offset = 1520
		  If Not Test(r, DecodeHex(offset1520)) Then Return False
		  
		  r.Offset = 2032
		  If Not Test(r, DecodeHex(offset2032)) Then Return False
		  
		  r.Offset = 1008
		  If Not Test(r, DecodeHex(offset1008)) Then Return False
		  
		  r.Offset = 240
		  If Not Test(r, DecodeHex(offset240)) Then Return False
		  
		  r.Offset = 752
		  If Not Test(r, DecodeHex(offset752)) Then Return False
		  
		  r.Offset = 0
		  If Not Test(r, DecodeHex(offset0)) Then Return False
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
