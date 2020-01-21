package com.shtrih.tools;

import com.shtrih.scale.ScaleSerial;
import java.util.HashMap;
import org.apache.log4j.Logger;

public abstract class ParamsMap<T> {
	
	//private final Logger logger = Logger.getLogger(ParamsMap.class);
	protected HashMap<String, Value> params =  new HashMap<String, Value>();
	
	public ParamsMap() { }
	
	public Value add(String key, Value value) 
        {
            //logger.debug("add(" + key + ": " + value + ")");
            return this.params.put(key, value);
	}	
	
	public Value add(String key, T value) {
            //logger.debug(key + ": " + value);
            return this.params.put(key, new Value(value));
	}	
	
	public Value get(String key) {
            //logger.debug("get(" + key + ")");
            return this.params.get(key);
	}
	
	public Value set(String key, Value value) {
            //logger.debug("set(" + key + ": " + value + ")");
            return add(key, value);
	}
	
	public void setValue(String key, T value) {
		Value val = get(key);
		if (val == null) {
			val = new Value(value);
			add(key, val);
		} else val.setValue(value);
	}
	
	public abstract T getValue(String key);
	
	public void clear() { 
		this.params.clear();
	}
	
	public void delete(String key) {
		this.params.remove(key);
	}	
	
	public class Value {
		private T value;
		private Object obj;
		
		public Value(T value) {
			this.value = value;
		}
		public Value(T value, Object obj) {
			this(value);
			this.obj = obj;
		}
		public T getValue() { return this.value; }
		public void setValue(T value) { this.value = value; }
		public Object object() { return this.obj; }
	}

}
