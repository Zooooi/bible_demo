package projectComponents.bible.vo
{
	
	
	public class ExerciseVO extends BibleScore
	{
		
		public const degreeMin:uint = 1;
		public const degreeMax:uint = 7;
		
		
		[Bindable]public var degree:uint = 1;
		[Bindable]public var tips:uint
		[Bindable]public var compare:uint
		[Bindable]public var fast:uint = 1;
		
		[Bindable]public var tips_total:uint
		[Bindable]public var compare_total:uint
		[Bindable]public var fast_total:uint
		
		/** 對應級數每個字的分數增幅*/
		[Bindable]public var score:Number 
		
		/** 道具不使用後的增幅 */
		[Bindable]public var gif:Number
		[Bindable]public var gif_fast:Number
		
		/** 用时增幅 */
		[Bindable]public var dropSecond:Number
		
		[Bindable]public var bTips_Selected:Boolean = false;
		[Bindable]public var bCompare_Selected:Boolean = false;
		
		
		
		public function ExerciseVO(obj:Object=null)
		{
			super(obj);
		}
		
		
	}
}