Ext.define
(
	"Sbi.chart.designer.ChartConfigurationParallelLegend", 
	
	{
		extend: 'Ext.panel.Panel',
		id: "chartParallelLegend",
		
		/**
		 * NOTE: 
		 * This is a temporal solution (for bugs ATHENA-154 and ATHENA-157):
		 * Instead of using dynamic width for this panel that relies
		 * on the width of the width of the window of the browser, fix this
		 * value so it can be entirely visible to the end user. Also the
		 * height will be defined as the fixed value.
		 * 
		 * @author: danristo (danilo.ristovski@mht.net)
		 */
//		columnWidth: 0.2,
		width: 200,
		height: 110,
		
		title: LN("sbi.chartengine.configuration.parallel.legend.title.panelTitle"),
		bodyPadding: 10,
		items: [],
		height: 110,
		
		requires : [
			            'Sbi.chart.designer.StylePopupTip',
			            'Sbi.chart.designer.StylePopupToolbar'
			            ],
	
	    fieldDefaults: 
	    {
	        anchor: '100%'
		},
		
		layout: 
		{
		    type: 'vbox',
		    //align: 'center'
		},
		
		constructor: function(config) 
		{
			this.callParent(config);
			this.viewModel = config.viewModel;
			
			var stylePopupLegendTitle = Ext.create
			(
				'Sbi.chart.designer.StylePopupLegendTitle',
				
				{
					title: LN("sbi.chartengine.configuration.parallel.legend.title.popupTitle"),
		        	viewModel: this.viewModel,
		        	
		        	bindLegendTitleFontFamily: '{configModel.parallelLegendTitleFontFamily}',
		        	bindLegendTitleFontSize: '{configModel.parallelLegendTitleFontSize}',
		        	bindLegendTitleFontWeight: '{configModel.parallelLegendTitleFontWeight}'
		        }
			);		
			
			var stylePopupLegendElement = Ext.create
			(
				'Sbi.chart.designer.StylePopupLegendElement',
				
				{
					title: LN("sbi.chartengine.configuration.parallel.legend.element.popupTitle"), 
		        	viewModel: this.viewModel,
		        	
		        	bindLegendElementFontFamily: '{configModel.parallelLegendElementFontFamily}',
		        	bindLegendElementFontSize: '{configModel.parallelLegendElementFontSize}',
		        	bindLegendElementFontWeight: '{configModel.parallelLegendElementFontWeight}'
		        }
			);
			
	        var item = 
        	[        	 	
        	 	{
        	 		xtype : 'fieldcontainer',
        			layout : 'hbox',
        			
        			defaults : 
        			{
        				// (top, right, bottom, left)
        				margin: '5 0 5 0'
        			},
        			
        			items:
    				[
    				 	{
    				 		xtype: 'label',
				 	        text: LN("sbi.chartengine.configuration.parallel.legend.title.labelTitle"), 
				 	        padding: "3 0 0 0"
//				 	        margin: '0 0 0 10'
    				 	},
    				 	
    				 	{
    				 		xtype : 'button',
    	    	            text: LN("sbi.chartengine.configuration.parallel.legend.title.configureButton"),	 
    	    	            margin: '5 20 5 30',
    	    	            
    	    	            handler: function()
    	    	            {
    	    	            	stylePopupLegendTitle.show();
    	    	            }
    				 	}
    				 ]
    				
    			},
    			
    			{
        	 		xtype : 'fieldcontainer',
        			layout : 'hbox',
        			
        			defaults : 
        			{
        				// (top, right, bottom, left)
        				margin: '0 0 5 0'
        			},
        			
        			items:
    				[
    				 	{
							xtype: 'label',
							text: LN("sbi.chartengine.configuration.parallel.legend.element.labelElement"), 
					     	padding: "3 0 0 0"
						},
						
    				 	{
		    				xtype : 'button',
		    	            text: LN("sbi.chartengine.configuration.parallel.legend.element.configureButton"),   
		    	            margin: '0 0 5 53',
		    	            
		    	            handler: function()
		    	            {
		    	            	stylePopupLegendElement.show();
		    	            }
    				 	}
    				 ]
    				
    			}
             ];
	        
	        this.add(item);
		}
});