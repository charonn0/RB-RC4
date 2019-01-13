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
		  Dim out As New MemoryBlock(0)
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
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function RandomBytes(Count As Integer, Seed As MemoryBlock) As MemoryBlock
		  Dim r As New RC4Stream(Seed)
		  Return r.RandomBytes(Count) 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  For i As Int32 = 0 To 255
		    Schedule(i) = i
		  Next
		  
		  Dim j As UInt32
		  For i As UInt32 = 0 To 255
		    j = (j + Schedule(i) + mKey.Int8Value(i Mod mKey.Size)) Mod 256
		    Dim tmp As Int32 = Schedule(i)
		    Schedule(i) = Schedule(j)
		    Schedule(j) = tmp
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mKey As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Schedule(255) As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StateI As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StateJ As Int32
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
