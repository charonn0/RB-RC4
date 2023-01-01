#tag Class
Protected Class RC4Stream
	#tag Method, Flags = &h0
		Sub Constructor(Key As MemoryBlock, DiscardLength As UInt64 = 0)
		  If Key.Size > 256 Then Raise New RuntimeException
		  mKey = Key
		  
		  ' initialize the Schedule array
		  For i As UInt32 = 0 To 255
		    Schedule(i) = i
		  Next
		  
		  ' reset the state
		  StateI = 0
		  StateJ = 0
		  
		  ' scramble the Schedule with the key to get the initial state
		  Dim j As UInt32
		  For i As UInt32 = 0 To 255
		    j = (j + Schedule(i) + mKey.UInt8Value(i Mod mKey.Size)) Mod 256
		    Dim tmp As UInt32 = Schedule(i)
		    Schedule(i) = Schedule(j)
		    Schedule(j) = tmp
		  Next
		  
		  mOffset = 0
		  Do Until DiscardLength = 0
		    Dim tmp As MemoryBlock = RandomBytes(Min(1024 * 1024 * 64, DiscardLength))
		    DiscardLength = DiscardLength - tmp.Size
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Process(Data As MemoryBlock) As MemoryBlock
		  ' Combines the bytes of the Data with an equal number of bytes from
		  ' the key stream, performing both encryption and decryption.
		  
		  Dim keystream As MemoryBlock = Me.RandomBytes(Data.Size)
		  For i As Integer = 0 To Data.Size - 1
		    Data.UInt8Value(i) = Data.UInt8Value(i) Xor keystream.UInt8Value(i)
		  Next
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RandomBytes(Count As Integer) As MemoryBlock
		  ' Returns the specified number of bytes from the key stream. Since the keystream is unpredictable without knowing the
		  ' key (or the seed in this case) it can be used as a pseudo-random number generator.
		  
		  Dim keystream As New MemoryBlock(Count)
		  For i As UInt32 = 0 To Count - 1
		    StateI = (StateI + 1) Mod 256
		    StateJ = (StateJ + Schedule(StateI)) Mod 256
		    Dim tmp As Int32 = Schedule(StateI)
		    Schedule(StateI) = Schedule(StateJ)
		    Schedule(StateJ) = tmp
		    Dim k As UInt32 = (Schedule(StateI) + Schedule(StateJ)) Mod 256
		    keystream.UInt8Value(i) = Schedule(k)
		  Next
		  mOffset = mOffset + keystream.Size
		  Return keystream
		End Function
	#tag EndMethod


	#tag Note, Name = About this class
		Copyright (c) 2019-23 Andrew Lambert, All Rights Reserved
		Distributed under the MIT license.
		https://github.com/charonn0/RB-RC4
		
		The RC4Stream class implements the RC4 stream cipher. RC4 is vulnerable to several forms of
		attack and generally should not be used to secure important data. In particular there is no
		authentication provided. Use at your own risk.
		
		The RC4Stream.Constructor() initializes the key stream with the user's Key, optionally discarding
		initial bytes from the key stream. Discarding the first several thousand bytes from the key
		stream is strongly recommended to mitigate some of RC4's weaknesses.
		
		The RC4Stream.RandomBytes() method returns the specified number of bytes from the key stream.
		
		The RC4Stream.Process() method combines the user-provided bytes with an equal number of bytes
		from the key stream, performing both encryption and decryption.
		
		The RC4Stream.Offset property gets and sets the position in the key stream. This is useful for
		both resetting the key stream and for discarding initial bytes from the key stream. 
	#tag EndNote


	#tag Property, Flags = &h21
		Private mKey As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOffset As UInt64
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mOffset
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value < mOffset Then
			    Me.Constructor(mKey, value)
			  ElseIf value > mOffset Then
			    Call Me.RandomBytes(value - mOffset)
			  End If
			End Set
		#tag EndSetter
		Offset As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Schedule(255) As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StateI As UInt8
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StateJ As UInt8
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
