class S{
	
	enum{
		ACTIVITY,
		SM,
		TIMER,
		NOTIFY
	}
	
	var services;
	
    function initialize(_services) {
		services = _services;
    }

	function get(service){
		return services.get(service);
	}
}