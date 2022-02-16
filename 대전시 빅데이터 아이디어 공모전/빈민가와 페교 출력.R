# 패키지 설치
install.packages("ggmap")
install.packages("ggplot2")
library(ggmap)
library(ggplot2)

# API 키 입력(구글에서 본인의 API. 키를 받아야 한다)
register_google(key = "AIzaSyD1HJZt6ywR4ugFTtBgosyJ8eiKEO2Hf8g")

# 이름 입력 
names <- c("대동하늘공원인근","송자고택","청랑여중인근","신흥역인근","성남초인근")         

# 순서대로 주소 입력
addr <- c("대전광역시 동구 자양동 20-9",          
          "대전광역시 동구 소제동 진수2길 13",          
          "대전광역시 중구 부사동 424-16",          
          "대전광역시 동구 천동 토천3길 8",          
          "대전광역시 동구 성남동 508-70")       
# 주소를 경도,위도로 변환
gc <- geocode(enc2utf8(addr))

df <- data.frame(name=names,                
                 lon=gc$lon,                 
                 lat=gc$lat) 



cen <- c(mean(df$lon),mean(df$lat))

map <- get_googlemap(center=cen,                     
                     maptype="roadmap",                     
                     zoom=14,                     
                     marker=gc)
# 지도와 마커 출력하기
ggmap(map) 

# 지도, 이름, 마커 동시 출력하기
gmap <- ggmap(map)

gmap+geom_text(data=df,               
               aes(x=lon,y=lat),             
               size=3,              
               label=df$name) 


# 폐교 또는 폐교 위기인 학교 출력

names <- c("대동초등학교","동명초등학교 효평분교","진잠초등학교 방성분교",
           "충일여자고등학교","기성초등학교 길헌분교(학생수 6명)")         

# 순서대로 주소 입력
addr <- c("대전광역시 유성구 대동 323",          
          "대전광역시 동구 효평동 265",          
          "대전광역시 유성구 성북동 188-1",          
          "대전광역시 유성구 유성대로 110-29",          
          "대전광역시 서구 당고개길 48")       
# 주소를 경도,위도로 변환
gc <- geocode(enc2utf8(addr))

df <- data.frame(name=names,                
                 lon=gc$lon,                 
                 lat=gc$lat) 



cen <- c(mean(df$lon),mean(df$lat))

map <- get_googlemap(center=cen,                     
                     maptype="roadmap",                     
                     zoom=11,                     
                     marker=gc)

ggmap(map) 

gmap <- ggmap(map)

gmap+geom_text(data=df,               
               aes(x=lon,y=lat),                
               size=4,                
               label=df$name) 
