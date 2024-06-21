# 네트워크 만들기
install.packages("igraph")
library(igraph)

# 첫 번째 점 A가 중심(center = 1)이 되는 스타형 그래프 생성
G.star <- make_star(6, mode = "undirected", center = 1) %>%
  set_vertex_attr("name", value = c("A", "B", "C", "D", "E", "F"))
plot(G.star, vertex.color = rainbow(6), vertex.size = 60)
# 라벨 출력하고 싶지 않을 때
# plot(G.star, vertex.color = rainbow(6), vertex.size = 60, vertex.label = NA)

# 움직일 수 있는 그래프
tkplot(G.star, vertex.color = rainbow(6), vertex.size = 20)


library(igraph)
library(RColorBrewer)

G.star <- make_star(6, mode = "undirected", center = 1) %>%
    set_vertex_attr("name", value = c("A", "B", "C", "D", "E", "F"))

# display.brewer.all()
tkplot(G.star, vertex.color = brewer.pal(6,'Set2'), vertex.size = 20)


# 링 형태의 그래프(directed : 화살표 방향 유무)
G.ring <- make_ring(6, directed = FALSE, circular = TRUE) %>%
    set_vertex_attr("name", value = c("A", "B", "C", "D", "E", "F"))
tkplot(G.ring, vertex.color = rainbow(6), vertex.size = 20)


# Y자 형태의 그래프(간선, 노드 없는 비어있는 그래프로 초기화)
G.Y <- make_graph(edges = NULL, n = NULL, directed = FALSE)
# 노드 추가
G.Y <- G.Y + vertices("A", "B", "C", "D", "E", "F")
# 간선 추가
G.Y <- G.Y + edges("A", "B",
                   "A", "C",
                   "A", "D",
                   "D", "E",
                   "E", "F")
tkplot(G.Y, vertex.color = rainbow(6), vertex.size = 20)

