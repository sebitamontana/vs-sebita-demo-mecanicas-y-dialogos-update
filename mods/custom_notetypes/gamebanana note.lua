function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'gamebanana note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'bana'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'gamebanana note' then
		playSound('slice', 0.3);
		characterPlayAnim('dad', 'attack', false);
		characterPlayAnim('boyfriend', 'dodge', false);
		setProperty('boyfriend.specialAnim', false);
		setProperty('dad.specialAnim', false);
		cameraShake('camGame', 0.01, 0.2)
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'gamebanana note' and difficulty == 2 then
		setProperty('health', getProperty('health')-3);
		playSound('slice', 1);
		characterPlayAnim('dad', 'attack', true);
		characterPlayAnim('boyfriend', 'hurt', true);
	elseif noteType == 'gamebanana note' and difficulty == 1 then
		setProperty('health', getProperty('health')-3);
		playSound('slice', 0);
		characterPlayAnim('dad', 'attack', false);
		characterPlayAnim('boyfriend', 'hurt', true);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if loopsLeft >= 1 then
		setProperty('health', getProperty('health')-0.001);
	end
end