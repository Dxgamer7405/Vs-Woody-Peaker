package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitLeftWoody1:FlxSprite;
	var portraitLeftWoody2:FlxSprite;
	var portraitLeftWoody3:FlxSprite;
	var portraitLeftWoody4:FlxSprite;
	var portraitLeftWoody5:FlxSprite;
	var portraitLeftWoody6:FlxSprite;
	var portraitLeftWoody7:FlxSprite;
	var portraitLeftWoody8:FlxSprite;


	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'screwball':
				FlxG.sound.playMusic(Paths.music('Theme'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'knock':
				FlxG.sound.playMusic(Paths.music('Theme'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'real-gone':
				FlxG.sound.playMusic(Paths.music('Theme'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 95);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'screwball':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.setGraphicSize(Std.int(box.width * .2));
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

			case 'knock':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

			case 'real-gone':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(740, 125);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		// 1 is normal talkin, 2 is eyes closed talkin, 3 is PISSED, 4 is sad/surprised, 5 is talkin looking left, 6 is stern, 7 is talkin looking top left, and 8 is nervous

		portraitLeftWoody1 = new FlxSprite(100, 0);
		portraitLeftWoody1.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitOne');
		portraitLeftWoody1.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody1.updateHitbox();
		portraitLeftWoody1.scrollFactor.set();
		add(portraitLeftWoody1);
		portraitLeftWoody1.visible = false;
		
		portraitLeftWoody2 = new FlxSprite(100, 0);
		portraitLeftWoody2.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitTwo');
		portraitLeftWoody2.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody2.updateHitbox();
		portraitLeftWoody2.scrollFactor.set();
		add(portraitLeftWoody2);
		portraitLeftWoody2.visible = false;

		portraitLeftWoody3 = new FlxSprite(100, 0);
		portraitLeftWoody3.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitThree');
		portraitLeftWoody3.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody3.updateHitbox();
		portraitLeftWoody3.scrollFactor.set();
		add(portraitLeftWoody3);
		portraitLeftWoody3.visible = false;
		
		portraitLeftWoody4 = new FlxSprite(100, 0);
		portraitLeftWoody4.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitFour');
		portraitLeftWoody4.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody4.updateHitbox();
		portraitLeftWoody4.scrollFactor.set();
		add(portraitLeftWoody4);
		portraitLeftWoody4.visible = false;

		portraitLeftWoody5 = new FlxSprite(100, 0);
		portraitLeftWoody5.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitFive');
		portraitLeftWoody5.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody5.updateHitbox();
		portraitLeftWoody5.scrollFactor.set();
		add(portraitLeftWoody5);
		portraitLeftWoody5.visible = false;

		portraitLeftWoody6 = new FlxSprite(100, 0);
		portraitLeftWoody6.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitSix');
		portraitLeftWoody6.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody6.updateHitbox();
		portraitLeftWoody6.scrollFactor.set();
		add(portraitLeftWoody6);
		portraitLeftWoody6.visible = false;

		portraitLeftWoody7 = new FlxSprite(100, 0);
		portraitLeftWoody7.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitSeven');
		portraitLeftWoody7.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody7.updateHitbox();
		portraitLeftWoody7.scrollFactor.set();
		add(portraitLeftWoody7);
		portraitLeftWoody7.visible = false;

		portraitLeftWoody8 = new FlxSprite(100, 0);
		portraitLeftWoody8.frames = Paths.getSparrowAtlas('weeb/WoodyPortraitEight');
		portraitLeftWoody8.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftWoody8.updateHitbox();
		portraitLeftWoody8.scrollFactor.set();
		add(portraitLeftWoody8);
		portraitLeftWoody8.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * 0.7));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

#if android
var justTouched:Bool = false;

for (touch in FlxG.touches.list)
{
        if (touch.justPressed)
        {
               justTouched = true;
        }
}
#end

		if (FlxG.keys.justPressed.ANY #if android || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'screwball' || PlayState.SONG.song.toLowerCase() == 'knock' || PlayState.SONG.song.toLowerCase() == 'real-gone')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitLeftWoody1.visible = false;
						portraitLeftWoody2.visible = false;
						portraitLeftWoody3.visible = false;
						portraitLeftWoody4.visible = false;
						portraitLeftWoody5.visible = false;
						portraitLeftWoody6.visible = false;
						portraitLeftWoody7.visible = false;
						portraitLeftWoody8.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}

			case 'woodyone':
				portraitRight.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody1.visible = true;
					portraitLeftWoody1.animation.play('enter');
				}

			case 'woodytwo':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody2.visible = true;
					portraitLeftWoody2.animation.play('enter');
				}

			case 'woodythree':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody3.visible = true;
					portraitLeftWoody3.animation.play('enter');
				}

			case 'woodyfour':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody4.visible = true;
					portraitLeftWoody4.animation.play('enter');
				}

			case 'woodyfive':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody5.visible = true;
					portraitLeftWoody5.animation.play('enter');
				}

			case 'woodysix':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody7.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody6.visible = true;
					portraitLeftWoody6.animation.play('enter');
				}

			case 'woodyseven':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody8.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody7.visible = true;
					portraitLeftWoody7.animation.play('enter');
				}

			case 'woodyeight':
				portraitRight.visible = false;
				portraitLeftWoody1.visible = false;
				portraitLeftWoody2.visible = false;
				portraitLeftWoody3.visible = false;
				portraitLeftWoody4.visible = false;
				portraitLeftWoody5.visible = false;
				portraitLeftWoody6.visible = false;
				portraitLeftWoody7.visible = false;
				if (!portraitLeftWoody1.visible)
				{
					portraitLeftWoody8.visible = true;
					portraitLeftWoody8.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
