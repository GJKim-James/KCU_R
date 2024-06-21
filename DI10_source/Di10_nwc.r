# 네트워크 분석하기 
install.packages("igraph")
library(igraph)

G.star <- make_star(6, mode = "undirected", center = 1) %>%
    set_vertex_attr("name", value = c("A", "B", "C", "D", "E", "F"))
tkplot(G.star, vertex.color = rainbow(6), vertex.size = 20)

G.ring <- make_ring(6, directed = FALSE, circular = TRUE) %>%
    set_vertex_attr("name", value = c("A", "B", "C", "D", "E", "F"))
tkplot(G.ring, vertex.color = rainbow(6), vertex.size = 20)

G.Y <- make_graph(edges = NULL, n = NULL, directed = FALSE)
G.Y <- G.Y + vertices("A", "B", "C", "D", "E", "F")
G.Y <- G.Y + edges("A", "B",
                   "A", "C",
                   "A", "D",
                   "D", "E",
                   "E", "F")
tkplot(G.Y, vertex.color = rainbow(6), vertex.size = 20)


# 연결 정도 중심성과 중심화

# 중심성
degree(G.star, normalized = FALSE)
# 정규화시킨 값
degree(G.star, normalized = TRUE)

# 중심화
CD <- centralization.degree(G.star, normalized = FALSE)
CD

Tmax <- centralization.degree.tmax(G.star)
Tmax

# 표준화
CD$centralization / Tmax


# 근접 중심성과 중심화

# 중심성
closeness(G.star, normalized = FALSE)
# 정규화시킨 값
closeness(G.star, normalized = TRUE)

# 중심화
CC <- centralization.closeness(G.star, normalized = FALSE)
CC$centralization / (6-1)

CC$theoretical_max / (6-1)

CC$centralization / CC$theoretical_max


# 중개 중심성과 중심화

# 중심성
betweenness(G.star, normalized = FALSE)
# 정규화시킨 값
betweenness(G.star, normalized = TRUE)

# 중심화
CB <- centralization.betweenness(G.star, normalized = FALSE)
CB$centralization

CB$theoretical_max

CB$centralization / CB$theoretical_max


# 네트워크 밀도
graph.density(G.star)

graph.density(G.Y)

graph.density(G.ring)


# 최단 경로와 평균 거리
shortest.paths(G.Y)
shortest.paths(G.ring)
shortest.paths(G.star)

distances(G.Y, v = "A", to="E")
distances(G.Y, v = "A", to="B")


# 수업 시간에 다루지 않음
get.shortest.paths(G.Y, "A", "E")$vpath[[1]]

average.path.length(G.Y)
