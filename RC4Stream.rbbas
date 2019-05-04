#tag Class
Protected Class RC4Stream
	#tag Method, Flags = &h0
		Sub Constructor(Key As MemoryBlock)
		  If Key.Size > 256 Then Raise New RuntimeException
		  mKey = Key
		  Reset()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Process(Data As MemoryBlock) As MemoryBlock
		  Dim k As MemoryBlock = Me.RandomBytes(Data.Size)
		  Dim out As New MemoryBlock(Data.Size)
		  Dim bs As New BinaryStream(out)
		  For i As Integer = 0 To Data.Size - 1
		    bs.WriteUInt8(Data.UInt8Value(i) Xor k.UInt8Value(i))
		  Next
		  bs.Close
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Process(Data As MemoryBlock, Key As MemoryBlock) As MemoryBlock
		  Dim r As New RC4Stream(Key)
		  Return r.Process(Data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RandomBytes(Count As Integer) As MemoryBlock
		  Dim out As New MemoryBlock(0)
		  Dim outstream As New BinaryStream(out)
		  For x As UInt32 = 0 To Count - 1
		    StateI = (StateI + 1) Mod 256
		    StateJ = (StateJ + Schedule(StateI)) Mod 256
		    Dim tmp As Int32 = Schedule(StateI)
		    Schedule(StateI) = Schedule(StateJ)
		    Schedule(StateJ) = tmp
		    Dim k As UInt32 = (Schedule(StateI) + Schedule(StateJ)) Mod 256
		    outstream.WriteUInt8(Schedule(k))
		  Next
		  outstream.Close
		  mOffset = mOffset + out.Size
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset(DiscardLength As UInt64 = 0)
		  ' initialize the Schedule array
		  For i As UInt32 = 0 To 255
		    Schedule(i) = i
		  Next
		  
		  ' scramble the Schedule with the key to get the initial state
		  Dim j As UInt32
		  For i As UInt32 = 0 To 255
		    j = (j + Schedule(i) + mKey.Int8Value(i Mod mKey.Size)) Mod 256
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


	#tag Note, Name = About this class
		Copyright (c) 2019 Andrew Lambert, All Rights Reserved
		Distributed under the MIT license.
		
		This class implements the RC4 stream cipher. RC4 is vulnerable to several forms of attack and generally
		should not be used to secure important data. Use at your own risk.
		
		To encrypt and decrypt data use the Process() methods. The shared version of the method performs the
		entire operation at once and returns the output. The instance version of the method can perform the 
		operation as one or more separate calls, allowing streaming of long inputs.
		
		The RandomBytes() method returns the specified number of bytes from the RC4 key stream. The "Seed" parameter
		is used as a key for the RC4 key stream algorithm, but instead of using the key to encrypt a message
		the algorithm output itself is returned. As such, the bytes are not truly random: they are unpredictable
		without knowing the seed. Due to this, and the weakness of RC4 generally, this class should not be used as
		a cryptographically secure pseudo-random number generator.
		
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
			    Me.Reset(value)
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
