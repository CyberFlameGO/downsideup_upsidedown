import UnityEngine

class GUIDragTip (MonoBehaviour): 

	public target as GameObject
	private text = "Careful of hanging in mid-air, \nyour drag will prevent you from jumping high"

	private overhangTimer as single =0
	private playerScript as Player
	private player2Script as Player2


	def Start():
		playerScript = target.GetComponent(Player)
		player2Script = playerScript.GetOther().GetComponent(Player2)


	def Update ():
		partPhase = (playerScript.GetPhase()<1 and playerScript.GetPhase()>-1)
		topHanging = (playerScript.GetGrounded() and not player2Script.GetGrounded())
		botHanging = (not playerScript.GetGrounded() and player2Script.GetGrounded())
		if guiText and (topHanging or botHanging) and partPhase:
			startUpText = GameObject.Find("FirstInstructions")

			if not startUpText:
				if overhangTimer==0:
					overhangTimer = Time.time

				guiText.text = text

				if (Time.time-overhangTimer)> 5:	
					Destroy(guiText)
					overhangTimer=0

		elif guiText and overhangTimer!=0 and Time.time-overhangTimer>5:	
					Destroy(guiText)
					overhangTimer=0


