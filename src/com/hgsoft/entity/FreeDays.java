package com.hgsoft.entity;



public class FreeDays  implements java.io.Serializable {


    /**
	 * �������
	 */
	private static final long serialVersionUID = 1L;
  

     private Integer feeRuleType;//�շ����ͣ���Ӧ��tb_FeeRuleTypeDef���ֶ�FeeRuleType
     private Integer type;//����0-��ʾValue��ֵ�����ڣ�1-��ʾValue��ֵ������
     private String value;//�������ֵ

    public FreeDays() {
    }

    public FreeDays(Integer feeRuleType, Integer type, String value) {
        this.feeRuleType = feeRuleType;
        this.type = type;
        this.value = value;
    }

    public Integer getFeeRuleType() {
        return this.feeRuleType;
    }
    
    public void setFeeRuleType(Integer feeRuleType) {
        this.feeRuleType = feeRuleType;
    }

    public Integer getType() {
        return this.type;
    }
    
    public void setType(Integer type) {
        this.type = type;
    }

    public String getValue() {
        return this.value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
   

    public boolean equals(Object other) {
        if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof FreeDays) ) return false;
		 FreeDays castOther = ( FreeDays ) other; 
        
		 return ( (this.getFeeRuleType()==castOther.getFeeRuleType()) || ( this.getFeeRuleType()!=null && castOther.getFeeRuleType()!=null && this.getFeeRuleType().equals(castOther.getFeeRuleType()) ) )
&& ( (this.getType()==castOther.getType()) || ( this.getType()!=null && castOther.getType()!=null && this.getType().equals(castOther.getType()) ) )
&& ( (this.getValue()==castOther.getValue()) || ( this.getValue()!=null && castOther.getValue()!=null && this.getValue().equals(castOther.getValue()) ) );
  }
  
  public int hashCode() {
        int result = 17;
        
        result = 37 * result + ( getFeeRuleType() == null ? 0 : this.getFeeRuleType().hashCode() );
        result = 37 * result + ( getType() == null ? 0 : this.getType().hashCode() );
        result = 37 * result + ( getValue() == null ? 0 : this.getValue().hashCode() );
        return result;
  }   







}