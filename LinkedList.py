class LinkedList(object):

	def __init__(self, head):
		
		self.head = head

	def addLast(self, nextNode):
		if(self.head.next == None):
			self.head.next = nextNode
		else:
			currentNode = self.head
			while(currentNode.next != None):
				currentNode = currentNode.next

			tempData = nextNode.data
			temp = Node(tempData)
			currentNode.next = temp
	def addFirst(self, nextNode):
		
		tempData = nextNode.data
		temp = Node(tempData)
		temp.next = self.head
		self.head = temp


	def pop(self):
		currentNode = self.head
		while(currentNode.next.next != None):
			currentNode = currentNode.next
		currentNode.next = None

	def printList(self):
		currentNode = self.head
		while(currentNode.next != None):
			print currentNode.data 
			currentNode = currentNode.next
		print currentNode.data

class Node(object):
	
	def __init__(self, data):

		self.data = data
		self.next = None

john = Node("john")
myFirstLinkedList = LinkedList(john)
omnia = Node("omnia")
jew = Node("jew")


for i in range(0,1000000):
	myFirstLinkedList.addFirst(omnia)

newArray = []

# for i in range(0,1000000):
# 	newArray.append(0)







