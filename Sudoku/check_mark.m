function output = check_mark(mark)
%   ����������壺������ mark ���
%   ������ĳһ���ӵ���������� mark ��Ϊ�㣬˵����·�в�ͨ���������ֵ��
    output = min(min(sum(mark, 3))); % ĳһ�� mark ȫ�㣬���޿�ѡ���ʾ��·��ͨ�����ﲻ�ط�֧�жϣ�output����Ϊ0��Ϊ1
end