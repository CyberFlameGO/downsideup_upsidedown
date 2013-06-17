import UnityEngine

class SoundEffects (MonoBehaviour): 
	
	private sfxVol = 1.0
	
	private zap = []
	private growl = []
	private uchatter = []
	private chain = []
	private door = []
	private hup = []
	private oof = []
	private ufoot = []
	private gfoot = []
	private pipe = []
	private box = []
	private plat = []
	private launch = []
	private stun = []
	private gdeath = []
	private splatter = []
	private achatter = []
	private phase = []
	private interidle = []
	private phasefail = []
	
	private intercom_queue = []
	private intercom_chime as AudioClip
	
	
	def Start ():
		audio.volume = 2.0
		intercom_chime = Resources.Load("interchime")
		
		for n in range(10):
			z = Resources.Load("zap" + n.ToString())
			if z != null:
				zap.Add(z)
			z = Resources.Load("growl" + n.ToString())
			if z != null:
				growl.Add(z)
			z = Resources.Load("chatter" + n.ToString())
			if z != null:
				uchatter.Add(z)
			z = Resources.Load("chain" + n.ToString())
			if z != null:
				chain.Add(z)
			z = Resources.Load("door" + n.ToString())
			if z != null:
				door.Add(z)
			z = Resources.Load("hup" + n.ToString())
			if z != null:
				hup.Add(z)
			z = Resources.Load("oof" + n.ToString())
			if z != null:
				oof.Add(z)
			z = Resources.Load("ufoot" + n.ToString())
			if z != null:
				ufoot.Add(z)
			z = Resources.Load("gfoot" + n.ToString())
			if z != null:
				gfoot.Add(z)
			z = Resources.Load("clang" + n.ToString())
			if z != null:
				pipe.Add(z)
			z = Resources.Load("box" + n.ToString())
			if z != null:
				box.Add(z)
			z = Resources.Load("plat" + n.ToString())
			if z != null:
				plat.Add(z)
			z = Resources.Load("launch" + n.ToString())
			if z != null:
				launch.Add(z)
			z = Resources.Load("stun" + n.ToString())
			if z != null:
				stun.Add(z)
			z = Resources.Load("gdeath" + n.ToString())
			if z != null:
				gdeath.Add(z)
			z = Resources.Load("splatter" + n.ToString())
			if z != null:
				splatter.Add(z)
			z = Resources.Load("achatter" + n.ToString())
			if z != null:
				achatter.Add(z)
			z = Resources.Load("phase" + n.ToString())
			if z != null:
				phase.Add(z)
			z = Resources.Load("interidle" + n.ToString())
			if z != null:
				interidle.Add(z)
			z = Resources.Load("phasefail" + n.ToString())
			if z != null:
				phasefail.Add(z)
	
	def Update ():
		if audio.isPlaying:
			sfxVol = 2.0
		else:
			if intercom_queue != []:
				audio.clip = intercom_queue.Pop(0)
				audio.Play()
			else:
				sfxVol = 3.0
			
	
	def PlayZap(position as Vector3):
		PlayClipAt(zap[Random.Range(0, zap.Count)], position, sfxVol)
		
	def PlayGrowl(position as Vector3):
		PlayClipAt(growl[Random.Range(0, growl.Count)], position, sfxVol)
		
	def PlayUchatter(position as Vector3):
		PlayClipAt(uchatter[Random.Range(0, uchatter.Count)], position, sfxVol)

	def PlayChain(position as Vector3):
		PlayClipAt(chain[Random.Range(0, chain.Count)], position, sfxVol)

	def PlayDoor(position as Vector3):
		PlayClipAt(door[Random.Range(0, door.Count)], position, sfxVol)
		
	def PlayHup(position as Vector3):
		PlayClipAt(hup[Random.Range(0, hup.Count)], position, sfxVol)
		
	def PlayOof(position as Vector3):
		PlayClipAt(oof[Random.Range(0, oof.Count)], position, sfxVol)
		
	def PlayUfoot(position as Vector3):
		PlayClipAt(ufoot[Random.Range(0, ufoot.Count)], position, sfxVol)
		
	def PlayGfoot(position as Vector3):
		PlayClipAt(gfoot[Random.Range(0, gfoot.Count)], position, sfxVol)
		
	def PlayPipe(position as Vector3):
		PlayClipAt(pipe[Random.Range(0, pipe.Count)], position, sfxVol)
		
	def PlayBox(position as Vector3):
		PlayClipAt(box[Random.Range(0, box.Count)], position, sfxVol)
		
	def PlayPlat(position as Vector3):
		PlayClipAt(plat[Random.Range(0, plat.Count)], position, sfxVol)
		
	def PlayLaunch(position as Vector3):
		PlayClipAt(launch[Random.Range(0, launch.Count)], position, sfxVol)
		
	def PlayStun(position as Vector3):
		PlayClipAt(stun[Random.Range(0, stun.Count)], position, sfxVol)
		
	def PlayGdeath(position as Vector3):
		PlayClipAt(gdeath[Random.Range(0, gdeath.Count)], position, sfxVol)
		
	def PlaySplatter(position as Vector3):
		PlayClipAt(splatter[Random.Range(0, splatter.Count)], position, sfxVol)
		
	def PlayAchatter(position as Vector3):
		PlayClipAt(achatter[Random.Range(0, achatter.Count)], position, sfxVol)
		
	def PlayPhase(position as Vector3):
		PlayClipAt(phase[Random.Range(0, phase.Count)], position, sfxVol)
		
	def PlayInteridle():
		intercom_queue.Add(intercom_chime)
		intercom_queue.Add(interidle[0])
		interidle.Add(interidle.Pop(0))
		
	def PlayPhasefail(position as Vector3):
		PlayClipAt(phasefail[Random.Range(0, phasefail.Count)], position, sfxVol)
		
	def PlayIntercom(clip as AudioClip):
		intercom_queue.Add(intercom_chime)
		intercom_queue.Add(clip)
		
		
	def PlayClipAt(clip as AudioClip, pos, vol):
		temp = GameObject("TempAudio")
		temp.transform.position = pos
		aSource as AudioSource = temp.AddComponent("AudioSource")
		aSource.volume = vol
		aSource.minDistance = 7.0
		aSource.clip = clip
		aSource.Play()
		Destroy(temp, clip.length)